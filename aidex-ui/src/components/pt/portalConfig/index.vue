<template>
  <div class="layout">
    <div class="content-box">
      <div class="container-center-left">
        <ul class="list-ul">
          <li v-for="item in waitLayout" :key="item.i">
            <div @drag="drag(item)" @dragend="dragend(item)" draggable="true" unselectable="on">{{ item.title }}</div>
          </li>

        </ul>
      </div>
      <div class="container-center-right" id="content">
        <grid-layout
          ref="gridLayout"
          :layout.sync="layout"
          :col-num="colNum"
          :row-height="30"
          :is-draggable="true"
          :is-resizable="true"
          :vertical-compact="verticalCompact"
          :margin="[10, 10]"
          :use-css-transforms="true"
          class="hoverStyle">
          <grid-item
            v-for="(item, index) in layout"
            :key="item.i"
            :x="item.x"
            :y="item.y"
            :w="item.w"
            :h="item.h"
            :i="item.i"
            style="border: 1px solid #fff; overflow: auto;"
          >
            <widget-form-item
              :key="item.i"
              :element="item"
              :index="index"
              :data="layout"

            />
            <span class="remove" @click="removeItem(item.i)">x</span>
          </grid-item>
        </grid-layout>

      </div>
    </div>
  </div>
</template>

<script>
  import VueGridLayout from 'vue-grid-layout'
  import AreaChart from '@/views/demo/chart/dashboard-chart.vue'
  import WidgetFormItem from './WidgetFormItem'
  const waitLayout = [{
      'x': 0,
      'y': 0,
      'w': 6,
      'h': 5,
      'i': '0',
      'title': '小页2',
      'key': 'AreaChart2',
      'isShowTitle': false,
      'name': 'sdf',
      'type': 'smallPage',
      'url': 'demo/chart/dashboard-chart.vue',
      'options': {
        'titleRequired': true,
        'moreUrl': '',
        'refresh': 1
      }
    },
    {
      'x': 2,
      'y': 0,
      'w': 6,
      'h': 10,
      'i': '1',
      'title': '小页3',
      'key': 'AreaChart3',
      'isShowTitle': false,
      'name': 'sdf',
      'type': 'smallPage',
      'url': 'demo/chart/echartDashBoard.vue',
      'options': {
        'titleRequired': true,
        'moreUrl': '',
        'refresh': 1
      }
    },
    {
      'x': 4,
      'y': 0,
      'w': 3,
      'h': 15,
      'i': '2',
      'title': '小页4',
      'key': 'AreaChart4',
      'isShowTitle': false,
      'name': 'sdf',
      'type': 'smallPage',
      'url': 'demo/chart/histogram-chart.vue',
      'options': {
        'titleRequired': true,
        'moreUrl': '',
        'refresh': 1
      }
    },
    {
      'x': 6,
      'y': 0,
      'w': 6,
      'h': 5,
      'i': '3',
      'title': '小页5',
      'key': 'AreaChart5',
      'isShowTitle': false,
      'name': 'sdf',
      'type': 'smallPage',
      'url': 'demo/chart/line-chart.vue',
      'options': {
        'titleRequired': true,
        'moreUrl': '',
        'refresh': 1
      }
    },
    {
      'x': 8,
      'y': 0,
      'w': 6,
      'h': 5,
      'i': '4',
      'title': '小页6',
      'key': 'AreaChart6',
      'isShowTitle': false,
      'name': 'sdf',
      'type': 'smallPage',
      'url': 'demo/chart/pie-chart.vue',
      'options': {
        'titleRequired': true,
        'moreUrl': '',
        'refresh': 1
      }
    }
  ]
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
    'title': null,
    'key': 'AreaChart'
  }
  document.addEventListener('dragover', function (e) {
    mouseXY.x = e.clientX
    mouseXY.y = e.clientY
  }, false)
  export default {
    components: {
      GridLayout: VueGridLayout.GridLayout,
      GridItem: VueGridLayout.GridItem,
      AreaChart,
      WidgetFormItem
    },
    data () {
      return {
        layout: [{
          'x': 0,
          'y': 0,
          'w': 6,
          'h': 5,
          'i': '0',
          'title': '小页1',
          'key': 'AreaChart',
          'isShowTitle': false,
          'name': 'sdf',
          'type': 'smallPage',
          'url': 'demo/chart/area-chart.vue',
          'options': {
            'titleRequired': true,
            'moreUrl': '',
            'refresh': 1
          }
        }],
        verticalCompact: true,
        colNum: 12, // 栅格数
        waitLayout: waitLayout,
        selectWidget: null
      }
    },
    methods: {
      drag: function (selectItem, e) {
        const parentRect = document.getElementById('content').getBoundingClientRect()
        let mouseInGrid = false
        if (((mouseXY.x > parentRect.left) && (mouseXY.x < parentRect.right)) && ((mouseXY.y > parentRect.top) && (
            mouseXY.y < parentRect.bottom))) {
          mouseInGrid = true
        }
        if (mouseInGrid === true && (this.layout.findIndex(item => item.i === 'drop')) === -1) {
          this.layout.push({
            x: (this.layout.length * 2) % (this.colNum || 12),
            y: this.layout.length + (this.colNum || 12), // puts it at the bottom
            w: selectItem.w,
            h: selectItem.h,
            i: 'drop'
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
            DragPos.i = String(index)
            DragPos.x = this.layout[index].x
            DragPos.y = this.layout[index].y
            DragPos.w = selectItem.w
            DragPos.h = selectItem.h
            DragPos.title = String(selectItem.title)
            DragPos.key = String(selectItem.key)
            DragPos.isShowTitle = String(selectItem.isShowTitle)
            DragPos.name = String(selectItem.name)
            DragPos.type = String(selectItem.type)
            DragPos.url = String(selectItem.url)
            DragPos.options = String(selectItem.options)
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
            y: DragPos.y,
            w: DragPos.w,
            h: DragPos.h,
            i: DragPos.i,
            title: DragPos.title,
            key: DragPos.key,
            isShowTitle: DragPos.isShowTitle,
            name: DragPos.name,
            type: DragPos.type,
            url: DragPos.url,
            options: DragPos.options
          })
          this.$refs.gridLayout.dragEvent('dragend', DragPos.i, DragPos.x, DragPos.y, DragPos.h, DragPos.w)
          try {
            this.$refs.gridLayout.$children[this.layout.length].$refs.item.style.display = 'block'
          } catch {}
        }
      },
      removeItem: function (val) {
         this.layout = this.layout.filter((item) => item.i !== val)
      }
    }
  }
</script>

<style lang="less">
  .layout {
    //background: #999;
    //height: 500px;
  }

  .hoverStyle {
    border: 1px solid #999;
  }

  #layout {
    font-family: 'Avenir', Helvetica, Arial, sans-serif;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    color: #2c3e50;
  }

  .content-box {
    width: 100%;
    height: 100%;
  }

  .container-center-left {
    width: 200px;
    height: 100%;
    background: #ffffff;
    overflow: auto;
    position: absolute;
    left: 0;
  }

  .list-ul {
    margin: 0 auto;
    list-style: none;
    width: 180px;
    padding: 10px 0 0;
  }

  .list-ul li {
    float: left;
    margin: 5px 0;
    display: inline-block;
    width: 100%;
  }

  .list-ul li div {
    padding: 6px 10px;
    display: inline-block;
    width: 100%;
    font-size: 14px;
    background: #f5f5f5;
  }

  .container-center-right {
    width: 100%;
    height: 100%;
  }

  .container-text {
    text-align: center;
    font-size: 32px;
    color: #585858;
    vertical-align: middle;
    padding: 50px 0;
  }

  .droppable-element {
    width: 150px;
    text-align: center;
    background: #fdd;
    border: 1px solid black;
    margin: 10px 0;
    padding: 10px;
  }

  .remove {
    position: absolute;
    right: 2px;
    top: 0;
    cursor: pointer;
  }
</style>
