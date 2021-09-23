<template>
  <div id="content" style="margin: -8px;">
    <portal-defined
      v-if="showPortalDefined"
      ref="portalDefined"
      @setPortalConfigs="setPortalConfigs"
      @close="showPortalDefined = false" />
    <grid-layout
      ref="gridLayout"
      :layout.sync="layout"
      :col-num="colNum"
      :row-height="1"
      :is-draggable="false"
      :is-resizable="false"
      :vertical-compact="verticalCompact"
      :margin="[0, 0]"
      :use-css-transforms="true"
      style="min-height: calc(100vh - 130px);"
      class="content-box">
      <grid-item
        v-for="(item, index) in layout"
        :key="item.i"
        :x="item.x"
        :y="item.y"
        :w="item.w"
        :h="item.h"
        :i="item.i"
        style="overflow: auto;">
        <widget-form-item
          :key="item.i"
          :element="item"
          :index="index"
          :data="layout"
          @setHeight="setHeight"
          :isShowTool="false" />
      </grid-item>
    </grid-layout>
  </div>
</template>

<script>
  import AntModal from '@/components/pt/dialog/AntModal'
  import VueGridLayout from 'vue-grid-layout'
  import WidgetFormItem from '@/components/pt/portalConfig/WidgetFormItem'
  import {
    updateDefaultPortalConfig,
    delSysPortalConfig
  } from '@/api/system/sysPortalConfig'
  import PortalDefined from '@/components/pt/portalConfig/PortalDefined'
  import {
    mapGetters
  } from 'vuex'
  let portalObj = [] // 记录页面结构
  const mouseXY = {
    'x': null,
    'y': null
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
      WidgetFormItem,
      PortalDefined
    },
    data () {
      return {
        layout: [],
        showPortalDefined: false,
        verticalCompact: true,
        portalConfigs: null,
        open: false,
        formTitle: '门户配置',
        colNum: 3, // 栅格数
        form: {},
        selectWidget: null
      }
    },
    computed: {
      ...mapGetters([
        'defaultPortal'
      ])
    },
    created () {
      this.getDefaultInfo()
    },
    methods: {
      /** 修改按钮操作 */
      reloadTab (obj) {
        // 通过工作台选择进入需要重新加载工作台布局信息
        this.layout = []
        this.form = obj
        if (this.form.content === null || this.form.content === '') {
          this.layout = []
        } else {
          this.layout = JSON.parse(this.form.content)
        }
        portalObj = this.layout
        if (obj.applicationRange === 'U') {
          // 执行后台方法保存默认工作台
          updateDefaultPortalConfig(obj).then(response => {})
        }
      },
      setHeight (height, item) {
        if (height !== null && height !== '' && height !== 'undefined') {
          item.h = height + 16
        }
      },
      designPortal (obj, portalConfigs, type) {
        if (type === 'delete') {
          // 请求删除操作
          var that = this
          this.$confirm({
            title: '确认删除小页【' + obj.name + '】',
            onOk () {
              return delSysPortalConfig(obj.id)
                .then(() => {
                  that.$message.success(
                    '删除成功',
                    3
                  )
                  that.open = false
                  that.portalConfigs.some((item, i) => {
                    if (item.id === obj.id) {
                      that.portalConfigs.splice(i, 1)
                    }
                  })
              })
            },
            onCancel () {}
          })
        } else {
          this.portalConfigs = portalConfigs
          this.showPortalDefined = true
          this.$nextTick(() => (
            this.$refs.portalDefined.show(obj, 'user')
          ))
        }
      },
      setPortalConfigs (portalConfig, type) {
        // 设计页面回调方法，当添加回调时需要将新添加的小页追加到小页列表
        if (type === 'add') {
          this.portalConfigs.push(portalConfig)
        }
        if (type === 'add' || type === 'edit') {
          // 添加编辑方法回调需要修改首页显示布局
          this.form = portalConfig
          this.layout = JSON.parse(this.form.content)
        }
        if (type === 'delete') {
          this.portalConfigs.some((item, i) => {
            if (item.id === portalConfig) {
              this.portalConfigs.splice(i, 1)
            }
          })
        }
      },
      getDefaultInfo () {
        // 工作台打开时加载用户默认小页
        this.layout = []
        const data = this.defaultPortal
        if (data.content === null || data.content === '') {
          this.layout = []
        } else {
          this.layout = JSON.parse(data.content)
        }
        portalObj = this.layout
      },
      loadInfo () {
        this.layout = portalObj
      },
      cancel () {
        this.open = false
        this.$emit('close')
      }
    }
  }
</script>

<style lang="less" scoped>
  @import '../../components/pt/portalConfig/style/index.less';
</style>
