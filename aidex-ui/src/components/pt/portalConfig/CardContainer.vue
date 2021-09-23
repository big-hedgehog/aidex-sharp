<template>
  <a-card
    class="box-card"
    :bordered="false"
    :body-style="{
      padding: '0px',
      overflow: 'auto',
      borderRadius: '4px',
      top: element.options.titleRequired ? '50px' : '0',
      bottom: '0px',
      left: '0px',
      right: '0px'
    }"
  >
    <div
      v-if="element.options.titleRequired && element.isSwith"
      slot="title"
      class="box-card-title module"
    >
      <a-tabs default-active-key="1">
        <div slot="tabBarExtraContent">
          <router-link v-if="element.options.moreUrl" :to="element.options.moreUrl">
          </router-link>
        </div>
        <a-tab-pane key="1">
          <template slot="tab">{{ element.options.title }}</template>
        </a-tab-pane>
      </a-tabs>
    </div>
    <div class="box-card-body" v-if="element.type == 'smallPage'" >
      <component ref="smallPages" :is="componentFile" @setHeight="setHeight"/>
    </div>
  </a-card>
</template>

<script>
export default {
  props: ['data', 'element'],
  name: 'CardContainer',
  components: {
  },
  data () {
    const ComponentFile = this.render
    return {
      componentFile: ComponentFile,
      loading: false, // 刷新按钮加载效果
      timer: null // 刷新定时器
    }
  },
  mounted () {
    const self = this
    /* 定时刷新 */
    if (this.element.options.titleRequired && this.element.options.refresh > 0) {
      const time = this.element.options.refresh * 60 * 1000
      this.timer = setInterval(self.loadData, time)
    }
  },
  methods: {
    /* 异步加载工作台小页组件 */
    render () {
      const url = this.element.url
      this.componentFile = () => ({
        component: import(`@views/${url}`),
        error: '',
        delay: 100,
        timeout: 10000
      })
    },
    setHeight (height) {
      this.$emit('setHeight', height)
    },
    reFreshData () {
      this.loadData()
    },
    /* 刷新工作台小页组件 */
    loadData () {
      if (this.loading) {
        return
      }
      this.loading = true
      if (this.$refs.smallPages) {
        if (typeof this.$refs.smallPages.loadData === 'function') {
          this.$refs.smallPages.loadData()
        }
      }
      const self = this
      setTimeout(() => {
        self.loading = false
      }, 300)
    }
  },
  beforeDestroy () {
    /* 销毁定时器 */
    clearInterval(this.timer)
  }
}
</script>

<style lang="less" scoped>
.box-card {
  position: relative;
  ::-webkit-scrollbar-thumb {
    border-width: 12px 0 0 12px !important;
  }
  > .ant-card-head::after {
    width: 4px;
    height: 24px;
    transform: perspective(0.5em) rotateY(25deg);
  }
  .box-card-body {
    height: 100%;

  }
}
</style>
