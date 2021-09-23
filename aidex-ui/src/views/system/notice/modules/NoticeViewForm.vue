<template>
  <ant-modal
    ref="antModalRef"
    :visible="open"
    :modal-title="formTitle"
    :adjustSize="false"
    :footer="null"
    dialogClass="designer-wrapper"
    @cancel="cancel">
    <div slot="content">
      <div class="top-box">
        <h2 class="title-h2">{{ form.noticeTitle }}({{ form.noticeType === '1' ? '通知' : '公告' }})</h2>
        <h3 class="time-h3">发布人：{{ form.createByName }}</h3>
        <h3 class="time-h3">发布时间：{{ form.createTime }}</h3>
      </div>
      <div class="weui_article">
        <div class="vditor-preview" style="display: block;">
          <div class="vditor-reset" style="max-width:100%;" v-html="form.noticeContentHtml">
            {{ form.noticeContentHtml }}
          </div>
        </div>
      </div>

      <a-form-model ref="form" :model="form" :rules="rules" slot="content" layout="vertical">
        <a-row class="form-row" :gutter="32">
          <a-col :lg="24" :md="24" :sm="24">
            <a-form-model-item label="公告附件" prop="status">
              <sys-upload
                key="1"
                element-id="1"
                form-type="edit"
                :drag-uploader="true"
                :multiple="true"
                :file-size-limit="40"
                :ref="attachmentRefName"
                :allow-encry="false"
                :allow-same-name="false"
                :allow-preview="true"
                :allow-download="true"
                :allow-delete="false"
                :allow-add="false"
                :chunk-enabled="true"
                :colspan="2"
                :form-id="formId"
                :file-num-limit="10"
                table-name="SYS_NOTICE"
                @afterUpload="uploadCompleteFile" />
            </a-form-model-item>
          </a-col>
        </a-row>
      </a-form-model>
    </div>
  </ant-modal>
</template>

<script>
  import NoticeForm from './NoticeForm'
  export default {
    ...NoticeForm
  }
</script>
<style lang="less" scoped>
  .top-box {
    background: #fff;
    margin-bottom: 10px;
    width: 100%;
    padding: 0.5em;
  }

  .top-box .title-h2 {
    color: #333333;
    font-size: 1.2em;
    text-align: center;
    padding: 0.35em;
    font-weight: bold;
  }

  .top-box .time-h3 {
    font-size: 0.85em;
    color: #858585;
    text-align: center;
  }

  .weui_article {
    padding: 20px 15px;
    background: #fff;
    font-size: 1em;
  }

  .weui_article h2 {
    font-size: 1.1em;
    font-weight: bold;
  }
</style>
