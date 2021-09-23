<template>
  <div>
    <portal-view v-if="showPortalView" ref="portalView" @close="showPortalView = false" />
    <ant-modal
      ref="antModalRef"
      :visible="open"
      :modal-title="formTitle"
      :adjustSize="false"
      :isShowTitle="false"
      :closeAble="false"
      :footer="null"
      dialogClass="designer-wrapper"
      @cancel="cancel">
      <div slot="content">
        <a-spin :spinning="spinning" :delay="delayTime" tip="加载中...">
          <a-layout>
            <a-layout-header>
              <a-row>
                <a-col :span="4">
                  <div class="logo-text">
                    <a-input v-model="form.name" placeholder="请输入工作台名称" />
                  </div>
                </a-col>
                <a-col :span="12">
                  <div class="header-tip">
                    您可以对卡片进行添加、移动等自定义操作
                  </div>
                </a-col>
                <a-col :span="8" text-align="right">
                  <div class="btn-group">
                    <a-button type="primary" @click="submitForm">保存</a-button>
                    <a-button @click="clearPortalConfig">清空</a-button>
                    <a-button type="danger" v-if="definedId !=='' && definedId !='null'" @click="deletePortalConfig">删除此工作台</a-button>
                    <a-button @click="handleView">预览</a-button>
                    <a-button @click="cancel">关闭</a-button>
                    </a-button>
                  </div>
                </a-col>
              </a-row>
            </a-layout-header>
            <a-layout>
              <a-layout-sider class="left-sider">
                <div class="sider-toptitle"><a-switch style="float:right" @change="switchChange"/>隐藏已添加模块</div>
                <div class="sider-toptitle side-top-line">
                  <a-select
                    style="width: 100%;"
                    placeholder="选择工作台模板布局"
                    @select="selectTemplate"
                    option-filter-prop="children">
                    <a-select-option
                      v-for="(item, index) in portalTemplateList"
                      :key="index"
                      :value="item.id"
                    >
                      {{ item.name }}
                    </a-select-option>
                  </a-select>
                </div>
                <ul class="list-ul">
                  <li v-for="item in waitLayout" :key="item.i" v-if="!switchValue || (switchValue && !item.isUsed)">
                    <!-- <a @drag="drag(item)" @dragend="dragend(item)" draggable="true" unselectable="on">{{ item.name }}</a> -->
                    <div
                      class="aside-item"
                      :title="item.name"
                      @click="selectPortal(item)"
                      @mouseover="waitMouseOver(item)"
                      @mouseleave="mouseOver = false"
                    >{{ item.name }}
                      <div class="aside-actions">
                        <a-icon v-if="!item.isUsed" type="plus" @click="selectPortal(item)" style="color: #0080FF;"/>
                        <transition name="slide-fade" mode="out-in">
                          <a-icon v-if="item.isUsed" type="check" />
                        </transition>
                        <transition name="slide-fade" mode="in-out">
                          <a-icon v-if="item.isUsed && mouseOver && currentItemId === item.i" type="close" @click.stop="removeItem(item.i)" style="color: #f20000;"/>
                        </transition>
                      </div>
                    </div>

                  </li>
                </ul>
              </a-layout-sider>
              <a-layout-content style="height: calc(100vh - 50px);overflow: auto;" id="scrollContent">
                <div id="content" style="height: 3000px">
                  <grid-layout
                    ref="gridLayout"
                    :layout.sync="layout"
                    :col-num="colNum"
                    :row-height="1"
                    :is-draggable="true"
                    :is-resizable="true"
                    :vertical-compact="verticalCompact"
                    :margin="[0, 0]"
                    :use-css-transforms="false"
                    :autoSize="true"
                    style="min-height: calc(100vh - 70px);"
                    class="content-box">
                    <grid-item
                      v-for="(item, index) in layout"
                      :id="item.i"
                      :min-h="2"
                      :key="item.code"
                      :x="item.x"
                      :y="item.y"
                      :isResizable="item.isAllowDrag"
                      :w="item.w"
                      :h="item.h"
                      :i="item.i"
                      @moved="itemMove">
                      <widget-form-item
                        :key="item.i"
                        :element="item"
                        :index="index"
                        :data="layout"
                        :isShowTool="true"
                        @click.native="clickItem(item.i,index)"
                        @removeItem="removeItem"
                        @setHeight="setHeight"
                        :acitviteFlag="activiteId === (item.i+index)"
                        :class="{ active: activiteId === (item.i+index) }" />
                      <!-- <span class="remove" @click="removeItem(item.i)">x</span> -->
                    </grid-item>
                  </grid-layout>
                </div>
              </a-layout-content>
              <a-layout-sider class="right-sider" v-if="false">
                <a-form-model-item label="标题">
                  <a-input v-model="form.fieldA" placeholder="标题文字" />
                </a-form-model-item>
                <a-form-model-item label="显示标题">
                  <a-switch default-checked v-model="form.fieldB" />
                </a-form-model-item>
                <a-form-model-item label="宽度">
                  <a-input-number id="inputNumber" v-model="form.fieldC" />
                  px
                </a-form-model-item>
                <a-form-model-item label="高度">
                  <a-input-number id="inputNumber" v-model="form.fieldD" />
                  px
                </a-form-model-item>
                <a-form-model-item label="小页路径">
                  <a-input disabled v-model="form.fieldE" type="textarea" />
                </a-form-model-item>
              </a-layout-sider>
            </a-layout>
          </a-layout>
        </a-spin>
      </div>
    </ant-modal>

  </div>
</template>
<script>
  import AntModal from '@/components/pt/dialog/AntModal'
  import VueGridLayout from 'vue-grid-layout'
  import WidgetFormItem from './WidgetFormItem'
  import PortalView from '@/components/pt/portalConfig/PortalView'
  import {
    getConfigAndPortalList,
    addSysPortalConfig,
    updateSysPortalConfig,
    delSysPortalConfig,
    getPortalTemplateList
  } from '@/api/system/sysPortalConfig'

  const mouseXY = {
    'x': null,
    'y': null
  }
  const DragPos = {
    'x': null,
    'y': null,
    'w': null,
    'h': null,
    'i': null,
    'key': null,
    'isShowTitle': null,
    'name': null,
    'type': null,
    'url': null,
    'options': null
  }
  document.addEventListener('dragover', function (e) {
    mouseXY.x = e.clientX
    mouseXY.y = e.clientY
  }, false)
  export default {
    components: {
      GridLayout: VueGridLayout.GridLayout,
      GridItem: VueGridLayout.GridItem,
      AntModal,
      PortalView,
      WidgetFormItem
    },
    data () {
      return {
        layout: [],
        currentLayout: {},
        portalTemplateList: [], // 模板列表
        switchValue: false,
        spinning: false,
        delayTime: 100,
        verticalCompact: true,
        showPortalView: false,
        mouseOver: false,
        currentItemId: '',
        definedId: '',
        open: false,
        formTitle: '门户配置',
        colNum: 3, // 栅格数
        activiteId: '',
        saveType: '', // 保存方式，sys系统定义，user用户自定义
        form: {
          layout: 'horizontal',
          fieldA: '',
          fieldB: '',
          fieldC: '',
          fieldD: '',
          fieldE: ''
        },
        waitLayout: [],
        selectWidget: null
      }
    },
    computed: {
      formItemLayout () {
        const {
          layout
        } = this.form
        return layout === 'horizontal'
          ? {
            labelCol: {
              span: 4
            },
            wrapperCol: {
              span: 14
            }
          }
          : {}
      }
    },
    created () {
      this.getPortalTemplate()
    },
    methods: {
      /** 修改按钮操作 */
      show (row, type) {
        this.spinning = true
        this.saveType = type
        this.open = true
        this.$nextTick(() => (
          this.$refs.antModalRef.setMaxDiolog()
        ))
        this.definedId = row === undefined ? 'null' : row.id
        // 获取待拖拽区域集合
        getConfigAndPortalList(this.definedId).then(response => {
          if (response.data.data === null) {
            this.layout = []
          } else {
            this.form = response.data.data
            if (this.form.content === null || this.form.content === '') {
              this.layout = []
            } else {
              this.layout = JSON.parse(this.form.content)
            }
          }
          this.buildWaitLayout(response.data.sysPortletList, this.waitLayout)
          this.spinning = false
        })
      },
      waitMouseOver (item) {
        // 鼠标移动到待添加小页区域
         this.mouseOver = true
         this.currentItemId = item.i
      },
      clickItem (id, index) {
        // 记录当前激活portal
        this.activiteId = id + index
      },
      handleView () {
        this.showPortalView = true
        this.form.content = JSON.stringify(this.layout)
        this.$nextTick(() => (
          this.$refs.portalView.show(this.form)
        ))
      },
      buildWaitLayout (dataList, toList) {
        dataList.forEach(data => {
          // 确认左侧列表是否已经在右侧区域存在
          const checkData = this.layout.filter(function (item) {
            return item.i === data.id
          })
          let isUsed = false
          if (checkData.length > 0) {
            isUsed = true
          }
          const layoutInfo = {
            'x': 0,
            'y': 0,
            'w': data.xGridNumber == null ? 6 : parseInt(data.xGridNumber),
            'h': data.yGridNumber == null ? 5 : parseInt(data.yGridNumber),
            'i': data.id,
            'key': data.code,
            'isShowTitle': data.showTitle,
            'isAllowDrag': data.isAllowDrag !== 'N',
            'name': data.name,
            'type': 'smallPage',
            'url': data.url,
            'isUsed': isUsed,
            'options': {
              'titleRequired': true,
              'moreUrl': '',
              'refresh': 1
            }
          }
          toList.push(layoutInfo)
        })
      },
      cancel () {
        this.open = false
        this.$emit('close')
      },
      drag: function (selectItem, e) {
        const parentRect = document.getElementById('content').getBoundingClientRect()
        let mouseInGrid = false
        if (((mouseXY.x > parentRect.left) && (mouseXY.x < parentRect.right)) && ((mouseXY.y > parentRect.top) && (
            mouseXY.y < parentRect.bottom))) {
          mouseInGrid = true
        }
        if (mouseInGrid === true && (this.layout.findIndex(item => item.i === 'drop')) === -1) {
          this.layout.push({
            x: (this.layout.length * 2) % (this.colNum || 3),
            y: this.layout.length + (this.colNum || 3), // puts it at the bottom
            w: selectItem.w,
            h: selectItem.h,
            i: 'drop',
            'key': selectItem.code,
            'isShowTitle': selectItem.showTitle,
            'isAllowDrag': selectItem.isAllowDrag,
            'name': selectItem.name,
            'type': 'smallPage',
            'url': selectItem.url,
            'options': {
              'titleRequired': true,
              'moreUrl': '',
              'refresh': 1
            }
          })
        }
        const index = this.layout.findIndex(item => item.i === 'drop')
        if (index !== -1) {
          try {
            this.$refs.gridLayout.$children[this.layout.length].$refs.item.style.display = 'none'
          } catch {}
          const el = this.$refs.gridLayout.$children[index]
          el.dragging = {
            'top': mouseXY.y - parentRect.top,
            'left': mouseXY.x - parentRect.left
          }
          const newPos = el.calcXY(mouseXY.y - parentRect.top, mouseXY.x - parentRect.left)
          if (mouseInGrid === true) {
            this.$refs.gridLayout.dragEvent('dragstart', 'drop', newPos.x, newPos.y, selectItem.h, selectItem.w)
            DragPos.i = String(selectItem.i)
            DragPos.x = this.layout[index].x
            DragPos.y = this.layout[index].y
            DragPos.w = selectItem.w
            DragPos.h = selectItem.h
            DragPos.key = String(selectItem.key)
            DragPos.isShowTitle = String(selectItem.isShowTitle)
            DragPos.isAllowDrag = selectItem.isAllowDrag
            DragPos.name = String(selectItem.name)
            DragPos.type = String(selectItem.type)
            DragPos.url = String(selectItem.url)
            DragPos.options = selectItem.options
            DragPos.index = index
          }
          if (mouseInGrid === false) {
            this.$refs.gridLayout.dragEvent('dragend', 'drop', newPos.x, newPos.y, selectItem.h, selectItem.w)
            this.layout = this.layout.filter(obj => obj.i !== 'drop')
          }
        }
      },
      dragend: function (selectItem, e) {
        const parentRect = document.getElementById('content').getBoundingClientRect()
        let mouseInGrid = false
        if (((mouseXY.x > parentRect.left) && (mouseXY.x < parentRect.right)) && ((mouseXY.y > parentRect.top) && (
            mouseXY.y < parentRect.bottom))) {
          mouseInGrid = true
        }
        if (mouseInGrid === true) {
          this.$refs.gridLayout.dragEvent('dragend', 'drop', DragPos.x, DragPos.y, DragPos.h, DragPos.w)
          this.layout = this.layout.filter(obj => obj.i !== 'drop')
          // UNCOMMENT below if you want to add a grid-item
          this.layout.push({
            x: DragPos.x,
            y: DragPos.y + 32,
            w: DragPos.w,
            h: DragPos.h + 16,
            i: DragPos.i,
            key: DragPos.key,
            isShowTitle: DragPos.isShowTitle,
            isAllowDrag: DragPos.isAllowDrag,
            name: DragPos.name,
            type: DragPos.type,
            url: DragPos.url,
            options: JSON.stringify(DragPos.options)
          })
          this.activiteId = DragPos.i + DragPos.index
          this.$refs.gridLayout.dragEvent('dragend', DragPos.i, DragPos.x, DragPos.y, DragPos.h, DragPos.w)
          try {
            this.$refs.gridLayout.$children[this.layout.length].$refs.item.style.display = 'block'
          } catch {}
        }
      },
      selectPortal: function (item) {
        if (item.isUsed) { // 已经使用的小页禁止继续添加
          return
        }
        let layoutX = 0
        if (item.w === 1) {
          layoutX = 2
        }
        const maxY = this.getMaxY(item.w)
        this.currentLayout = {
          id: item.i,
          x: layoutX,
          y: maxY,
          w: item.w,
          h: item.h + 16,
          i: item.i,
          key: item.key,
          isShowTitle: item.isShowTitle,
          isAllowDrag: item.isAllowDrag,
          name: item.name,
          type: item.type,
          url: item.url,
          options: JSON.stringify(item.options)
        }
        this.layout.push(this.currentLayout)
        item.isUsed = true
      },
      getMaxY (w) {
        const layoutList = JSON.parse(JSON.stringify(this.layout))
        let maxY = 0
        let maxYData = null
        if (layoutList.length === 0) {
          return 0
        }
        if (w === 1) {
          layoutList.forEach(data => {
            if ((data.w === 1 && data.x === 2) || (data.w = 2 && data.x === 1) || data.w === 3) {
              if (data.y >= maxY) {
                maxY = data.y
                maxYData = data
              }
            }
          })
        } else if (w === 2) {
          layoutList.forEach(data => {
            if (data.x === 0) {
              if (data.y >= maxY) {
                maxY = data.y
                maxYData = data
              }
            }
          })
        } else if (w === 3) {
          layoutList.forEach(data => {
            if (data.y >= maxY) {
              maxY = data.y
              maxYData = data
            }
          })
        }
        if (maxYData === null) {
          maxY = maxY + 16
        } else {
          maxY = maxY + maxYData.h + 16
        }
        this.$nextTick(() => {
          setTimeout(() => {
            // 将滚动条定位到这个高度位置
            document.getElementById('scrollContent').scrollTop = maxY
          }, 100)
        })
        return maxY
      },
      setHeight (height, item) {
        if (height !== null && height !== '' && height !== 'undefined') {
          // this.currentLayout.h = height + 16
          item.h = height + 16
        }
      },
      itemMove: function (i, newX, newY) {

      },
      clearPortalConfig: function () {
        this.layout = []
        this.waitLayout.forEach(data => {
          data.isUsed = false
        })
      },
      removeItem: function (val) {
        this.layout = this.layout.filter((item) => item.i !== val)

        const checkData = this.waitLayout.filter(function (item) {
          return item.i === val
        })
        if (checkData.length > 0) {
          checkData[0].isUsed = false
        }
      },
      submitForm: function () {
        this.form.content = JSON.stringify(this.layout)
        this.form.saveType = this.saveType
        if (this.definedId === 'null') {
          // 添加工作台设计
          addSysPortalConfig(this.form).then(response => {
            this.form = response.data
            this.$emit('setPortalConfigs', this.form, 'add')
            this.definedId = this.form.id
            this.$message.success('设计成功', 3)
          })
        } else {
          updateSysPortalConfig(this.form).then(response => {
            this.form = response.data
            this.$emit('setPortalConfigs', this.form, 'edit')
            this.$message.success('设计成功', 3)
          })
        }
      },
      switchChange (checked, e) {
          this.switchValue = checked
      },
      deletePortalConfig () {
        var that = this
        this.$confirm({
          title: '确认删除小页【' + that.form.name + '】',
          onOk () {
            return delSysPortalConfig(that.definedId)
              .then(() => {
                that.$message.success(
                  '删除成功',
                  3
                )
                that.$emit('setPortalConfigs', that.definedId, 'delete')
                that.open = false
                that.$emit('close')
            })
          },
          onCancel () {}
        })
      },
      getPortalTemplate () {
        // 获取模板列表数据
        getPortalTemplateList().then(response => {
          this.portalTemplateList = response.data
        })
      },
      selectTemplate (value, option) {
        const checkData = this.portalTemplateList.filter(function (item) {
          return item.id === value
        })
        this.layout = JSON.parse(checkData[0].content)
        this.waitLayout.forEach(data => {
          // 确认左侧列表是否已经在右侧区域存在
          const checkData = this.layout.filter(function (item) {
            return item.i === data.i
          })
          if (checkData.length > 0) {
            data.isUsed = true
          } else {
            data.isUsed = false
          }
        })
      }
    }
  }
</script>
<style lang="less" >
@import './style/index.less';
</style>
