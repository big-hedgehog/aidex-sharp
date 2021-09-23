<template>
  <div
    class="fm-widget-view"
    v-if="element && element.key"
    :label="element.name"
    @click.stop="handleSelectWidget(index)"
  >
    <template v-if="element.type == 'smallPage'" >
      <CardContainer :data="data" :element="element" @setHeight="setHeight"/>
    </template>
    <div class="fm-widget-view-action" v-if="isShowTool">
      <!--  <span title="设置" @click.stop="handleWidgetOpensSet(index)"><a-icon type="setting" /></span>
      <span title="拖动小页"> <a-icon type="drag" /></span>
      <span title="复制小页" @click.stop="handleWidgetClone(index)"><a-icon type="copy" /></span> -->
      <span title="删除小页" @click.stop="handleWidgetDelete(index)"><a-icon type="delete" /></span>
    </div>
  </div>
</template>

<script>
import CardContainer from './CardContainer'

export default {
  props: ['element', 'select', 'index', 'data', 'layout', 'isShowTool', 'acitviteFlag'],
  components: {
    // FmUpload,
    CardContainer
  },
  data () {
    return {
      selectWidget: this.select
    }
  },
  methods: {
    setHeight (height) {
      this.$emit('setHeight', height, this.element)
    },
     handleSelectWidget (index) {
      this.selectWidget = this.data[index]
    },
     handleWidgetOpensSet () {
      this.$emit('handleWidgetOpensSet')
    },
    handleWidgetDelete (index) {
      this.$emit('removeItem', this.element.i)
    },
      handleWidgetClone (index) {
      let cloneData = {
        ...this.data.list[index],
        options: { ...this.data.list[index].options },
        key: Date.parse(new Date()) + '_' + Math.ceil(Math.random() * 99999),
        i: this.data.list.length + ''
      }

      if (
        this.data.list[index].type === 'radio' ||
        this.data.list[index].type === 'checkbox' ||
        this.data.list[index].type === 'select'
      ) {
        cloneData = {
          ...cloneData,
          options: {
            ...cloneData.options,
            options: cloneData.options.options.map(item => ({ ...item }))
          }
        }
      }

      this.data.list.splice(index, 0, cloneData)

      this.$nextTick(() => {
        this.selectWidget = this.data.list[index + 1]
      })
    }
  },
  watch: {
    select (val) {
      this.selectWidget = val
    },
    selectWidget: {
      handler (val) {
        this.$emit('update:select', val)
      },
      deep: true
    }
  }
}
</script>
<style lang="less">
  .fm-widget-view-action{
    position: absolute;
    top: 0px;
    right: 5px;
    height: 20px;
    z-index: 9;
    .anticon{
      cursor: pointer;
      display: inline-block;
      margin: 0 3px;
      padding: 3px;
      background: #f2f2f2;
      border-radius: 2px;
      color:#b5b5b5;
    }
  }
</style>
