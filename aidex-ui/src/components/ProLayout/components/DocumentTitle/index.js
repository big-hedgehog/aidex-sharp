// import SideEffect from './SideEffect'
import { setDocumentTitle } from './util'

// const sideEffect = new SideEffect({
//   propsToState (propsList) {
//     var innermostProps = propsList[propsList.length - 1]
//     if (innermostProps) {
//       return innermostProps.title
//     }
//   },
//   handleStateChange (title, prefix) {
//     console.log('title', title, prefix)
//     const nextTitle = `${(title || '')} - ${prefix}`
//     if (nextTitle !== document.title) {
//       setDocumentTitle(nextTitle)
//     }
//   }
// })

const handleStateChange = (title, prefix) => {
  const nextTitle = `${(title || '')} - ${prefix}`
  if (nextTitle !== document.title) {
    setDocumentTitle(nextTitle)
  }
}

const DocumentTitle = {
  name: 'DocumentTitle',
  functional: true,
  props: {
    prefix: {
      type: String,
      required: false,
      default: 'Ant Design Pro'
    },
    title: {
      type: String,
      required: true
    }
  },
  // { props, data, children }
  // eslint-disable-next-line
  render (createElement, { props, data, children }) {
    handleStateChange(props.title, props.prefix)
    return children
  }
}

DocumentTitle.install = function (Vue) {
  // const mountedInstances = []
  // let state

  // function __emit (sideEffect) {
  //   const options = sideEffect.options
  //   state = options.propsToState(mountedInstances.map(function (instance) {
  //     return instance
  //   }))

  //   options.handleStateChange(state)
  // }

  // Vue.mixin({
  //   beforeMount () {
  //     const sideEffect = this.$options.sideEffect
  //     if (sideEffect) {
  //       mountedInstances.push(this)
  //       __emit(sideEffect)
  //     }
  //   },
  //   updated () {
  //     const sideEffect = this.$options.sideEffect
  //     if (sideEffect) {
  //       __emit(sideEffect)
  //     }
  //   },
  //   beforeDestroy () {
  //     const sideEffect = this.$options.sideEffect
  //     if (sideEffect) {
  //       const index = mountedInstances.indexOf(this)
  //       mountedInstances.splice(index, 1)
  //       __emit(sideEffect)
  //     }
  //   }
  // })

  Vue.component(DocumentTitle.name, DocumentTitle)
}

export default DocumentTitle
