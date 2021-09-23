import AntModal from '@/components/pt/dialog/AntModal'
import { getNotice, saveNotice, getNoticeView } from '@/api/system/notice'
import Vditor from 'vditor'
import 'vditor/dist/index.css'
export default {
  name: 'CreateForm',
  props: {
    typeOptions: {
      type: Array,
      required: true
    },
    statusOptions: {
      type: Array,
      required: true
    }
  },
  components: {
    AntModal,
    Vditor
  },
  data () {
    return {
      open: false,
      attachmentRefName: 'addUploaderFile', // 标志表单是否含有附件
      editAttachmentRefName: 'editUploaderFile',
      attachmentUploadStatus: true, // 记录的附件的上传状态
      uploaderButtonStatus: false, // 附件上传时按钮状态
      formId: '',
      labelCol: { span: 4 },
      wrapperCol: { span: 14 },
      loading: false,
      total: 0,
      id: undefined,
      formTitle: '',
      contentEditorEdit: '',
      // 表单参数
      form: {
        id: undefined,
        noticeTitle: undefined,
        noticeType: undefined,
        noticeContent: '',
        status: '0'
      },
      rules: {
        noticeTitle: [{ required: true, message: '公告标题不能为空', trigger: 'blur' }],
        noticeType: [{ required: true, message: '公告类型不能为空', trigger: 'change' }]
      },
      vditorToolbar: [// 将上传图片和录音按钮隐藏
                  'emoji',
                  'headings',
                  'bold',
                  'italic',
                  'strike',
                  'link',
                  '|',
                  'list',
                  'ordered-list',
                  'check',
                  'outdent',
                  'indent',
                  '|',
                  'quote',
                  'line',
                  'code',
                  'inline-code',
                  'insert-before',
                  'insert-after',
                  '|',
                  'table',
                  '|',
                  'undo',
                  'redo',
                  '|',
                  'fullscreen',
                  'edit-mode',
                  {
                    'name': 'more',
                    'toolbar': [
                      'both',
                      'code-theme',
                      'content-theme',
                      'export',
                      'outline',
                      'preview',
                      'devtools'
                    ]
                  }
                ]
    }
  },
  filters: {
  },
  created () {
  },
  computed: {
  },
  watch: {
  },
  mounted () {
  },
  methods: {
    // 取消按钮
    cancel () {
      this.open = false
      this.reset()
      this.$emit('close')
    },
    // 表单重置
    reset () {
      this.form = {
        id: undefined,
        noticeTitle: undefined,
        noticeType: undefined,
        noticeContent: '',
        status: '0'
      }
       if (this.formId) {
         // 清空附件的formId
         this.formId = ''
       }
    },
    handleAdd () {
      this.reset()
      this.open = true
      this.formTitle = '添加公告'
      this.$nextTick(() => {
        if (this.contentEditorEdit === '') {
          this.contentEditorEdit = new Vditor('vditor', {
            height: 180,
            toolbarConfig: {
              pin: true
            },
            toolbar: this.vditorToolbar,
            cache: {
              enable: false
            },
            after: () => {
              this.contentEditorEdit.setValue(this.form.noticeContent)
            }
          })
        } else {
          this.contentEditorEdit.setValue(this.form.noticeContent)
        }
      })
    },
    /** 修改按钮操作 */
    handleUpdate (row) {
      this.reset()
      const noticeId = row.id
      getNotice(noticeId).then(response => {
        this.open = true
        this.form = response.data
        this.formId = response.data.id
        this.formTitle = '修改公告'
        this.$nextTick(() => {
          if (this.contentEditorEdit === '') {
              this.contentEditorEdit = new Vditor('vditorEdit', {
                height: 360,
                toolbarConfig: {
                  pin: true
                },
                toolbar: this.vditorToolbar,
                cache: {
                  enable: false
                },
                after: () => {
                  this.contentEditorEdit.setValue(response.data.noticeContent)
                }
              })
          } else {
            this.contentEditorEdit.setValue(response.data.noticeContent)
          }
        })
      })
    },
    handleView (row) {
      this.reset()
      const noticeId = row.id
      getNoticeView(noticeId).then(response => {
        this.open = true
        this.$nextTick(() => (
            this.$refs.antModalRef.setMaxDiolog()
        ))
        this.form = response.data
        this.form.createByName = row.createByName
        this.formId = response.data.id
        this.formTitle = '公告详情'
        this.$emit('ok')
      })
    },
    /** 提交按钮 */
    submitForm: function () {
      const that = this
      this.form.noticeContent = this.contentEditorEdit.getValue()
      this.form.noticeContentHtml = this.contentEditorEdit.getHTML()
      this.$refs.form.validate(valid => {
        if (valid) {
          this.uploaderButtonStatus = true
          if (this.form.id !== undefined) {
            saveNotice(this.form).then(response => {
              if (that.attachmentRefName) {
                // 表单含有附件
                   that.formId = response.data.id // 附件上传formId
                   that.$refs[that.attachmentRefName].upload(that.formId) // 附件上传
              } else {
                this.$message.success(
                  '修改成功',
                  3
                )
                this.open = false
                this.$emit('ok')
                this.$emit('close')
              }
            })
          } else {
               saveNotice(this.form).then(response => {
                  if (that.attachmentRefName) {
                    // 表单含有附件
                    if (that.formId === '') {
                       that.formId = response.data.id // 附件上传formId
                       that.$refs[that.attachmentRefName].upload(that.formId) // 附件上传
                    }
                  } else {
                    // 表单不含有附件
                    that.$message.success(
                      '新增成功',
                      3
                    )
                    that.open = false
                    that.$emit('ok')
                    this.$emit('close')
                  }
               })
          }
        } else {
          return false
        }
      })
    },
    uploadCompleteFile: function (successFile, errorFile) {
      if (errorFile.length > 0) {
        // 有附件保存失败的处理
        this.attachmentUploadStatus = false // 记录附件上传失败
           this.$refs[this.attachmentRefName].$el.scrollIntoView() // 页面滚动到附件位置
        this.uploaderButtonStatus = false // 按钮关闭loading状态
      } else {
        // 所有附件都保存成功的处理
        this.attachmentUploadStatus = true // 记录附件上传成功
        this.$message.success(
          '保存成功',
          3
        )
        this.open = false
        this.$emit('ok')
        this.$emit('close')
      }
       this.uploaderButtonStatus = false // 返回按钮可用
    },
    back () {
      this.$router.push('/system/notice')
    }
  }
}
