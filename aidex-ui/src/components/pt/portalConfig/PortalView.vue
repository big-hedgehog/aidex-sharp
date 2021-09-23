<template>
  <ant-modal
    ref="antModalRef"
    :visible="open"
    :modal-title="formTitle"
    :adjustSize="false"
    :footer="null"
    modalCutHeight="40"
    dialogClass="designer-wrapper"
    @cancel="cancel"
  >
    <div slot="content">
      <a-layout-content style="height: calc(100vh - 50px);background: #f0f2f5;">
        <div id="content" style="height: 100%;">
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
            style="min-height: calc(100vh - 70px);"
            class="content-box">
            <grid-item
              v-for="(item, index) in layout"
              :key="item.i"
              :x="item.x"
              :y="item.y"
              :w="item.w"
              :h="item.h"
              :i="item.i"
            >
              <widget-form-item
                :key="item.i"
                :element="item"
                :index="index"
                :data="layout"
                :isShowTool="false"
              />
            </grid-item>
          </grid-layout>
        </div>
      </a-layout-content>

    </div>
  </ant-modal>
</template>

<script>
  import AntModal from '@/components/pt/dialog/AntModal'
  import Split from '@/components/pt/split/Index'
  import VueGridLayout from 'vue-grid-layout'
  import WidgetFormItem from './WidgetFormItem'
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
      Split,
      WidgetFormItem
    },
    data () {
      return {
        layout: [],
        verticalCompact: true,
        open: false,
        formTitle: '预览',
        colNum: 3, // 栅格数
        form: {},
        waitLayout: [],
        selectWidget: null
      }
    },
    methods: {
      /** 修改按钮操作 */
      show (row) {
        this.open = true
        this.$nextTick(() => (
            this.$refs.antModalRef.setMaxDiolog()
        ))
        /* getConfigAndPortalList(row.id).then(response => {
           this.form = response.data.data
           if (this.form.content === null || this.form.content === '') {
             this.layout = []
           } else {
             this.layout = JSON.parse(this.form.content)
           }
           this.buildWaitLayout(response.data.sysPortletList, this.waitLayout)
        }) */
        this.form = row
        if (this.form.content === null || this.form.content === '') {
          this.layout = []
        } else {
          this.layout = JSON.parse(this.form.content)
        }
        this.formTitle = this.form.name
      },
      cancel () {
        this.open = false
        this.$emit('close')
      }
    }
  }
</script>

<style lang="less">

@import './style/index.less';
</style>
