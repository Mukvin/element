<script>
  import Vue from 'vue'
  export default {
    data() {
      var checkEmail = (rule, value, callback) => {
        if (!value) {
          return callback(new Error(this.$t('name')));
        }
        setTimeout(() => {
          if (value !== 'demo@kyligence.io') {
            callback(new Error('重置密码的目标邮箱不正确'));
          } else {
            callback();
          }
        }, 1000);
      };
      var validatePass = (rule, value, callback) => {
        if (value === '') {
          callback(new Error('请输入密码'));
        } else {
          if (this.ruleForm2.checkPass !== '') {
            this.$refs.ruleForm2.validateField('checkPass');
          }
          callback();
        }
      };
      var validatePass2 = (rule, value, callback) => {
        if (value === '') {
          callback(new Error('请再次输入密码'));
        } else if (value !== this.ruleForm2.pass) {
          callback(new Error('两次输入密码不一致!'));
        } else {
          callback();
        }
      };
      return {
        lang: 'zh-cn',
        form: {
          name: '',
          region: '',
          date1: '',
          date2: '',
          delivery: false,
          type: [],
          resource: '',
          desc: ''
        },
        formSize: 'medium',
        sizeForm: {
          name: '',
          region: '',
          date1: '',
          date2: '',
          delivery: false,
          type: [],
          resource: '',
          desc: ''
        },
        formInline: {
          clusterName: '',
          startDate: '',
          endDate: ''
        },
        labelPosition: 'top',
        formLabelAlign: {
          name: '',
          region: '',
          type: ''
        },
        ruleForm: {
          name: '',
          region: '',
          date1: '',
          date2: '',
          delivery: false,
          type: [],
          resource: '',
          desc: ''
        },
        ruleForm2: {
          pass: '',
          checkPass: '',
          email: ''
        },
        formLabelWidth: '80px',
        // rules: {
        //   name: [
        //     { required: true, message: this.$t('name'), trigger: 'blur' },
        //     { min: 3, max: 5, message: '长度在 3 到 5 个字符', trigger: 'blur' }
        //   ],
        //   region: [
        //     { required: true, message: '请选择活动区域', trigger: 'change' }
        //   ],
        //   date1: [
        //     { type: 'date', required: true, message: '请选择日期', trigger: 'change' }
        //   ],
        //   date2: [
        //     { type: 'date', required: true, message: '请选择时间', trigger: 'change' }
        //   ],
        //   type: [
        //     { type: 'array', required: true, message: '请至少选择一个活动性质', trigger: 'change' }
        //   ],
        //   resource: [
        //     { required: true, message: '请选择活动资源', trigger: 'change' }
        //   ],
        //   desc: [
        //     { required: true, message: '请填写活动形式', trigger: 'blur' }
        //   ]
        // },
        rules2: {
          pass: [
            { validator: validatePass, trigger: 'blur' }
          ],
          checkPass: [
            { validator: validatePass2, trigger: 'blur' }
          ],
          email: [
            { validator: checkEmail, trigger: 'blur' }
          ]
        },
        dynamicValidateForm: {
          domains: [{
            value: '',
            key: Date.now()
          }],
          email: ''
        },
        numberValidateForm: {
          age: ''
        },
        multipleFormOut: {
          name: '',
          region: '',
        },
        multipleFormIn1: {
          name: '',
          region: '',
        },
        multipleFormIn2: {
          name: '',
          region: '',
        },
      };
    },
    methods: {
      submitFormWithAction () {
        this.$refs.formAction.$el.submit()
      },
      changeLang (lang) {
        this.lang = lang;
        Vue.config.lang = lang;
      },
      onSubmit() {
        console.log('submit!');
      },
      submitForm(formName) {
        this.$refs[formName].validate((valid) => {
          if (valid) {
            alert('submit!');
          } else {
            console.log('error submit!!');
            return false;
          }
        });
      },
      submitForm2() {
        this.$refs.multipleFormOut.validate((isFormOutValid) => {
          this.$refs.multipleFormIn1.validate((isFormIn1Valid) => {
            this.$refs.multipleFormIn2.validate((isFormIn1Valid) => {
              if (isFormOutValid && isFormIn1Valid) {
                alert('submit!');
              } else {
                console.log('error submit!!');
                return false;
              }
            });
          });
        });
      },
      resetForm(formName) {
        this.$refs[formName].resetFields();
      },
      resetForm2() {
        this.$refs.multipleFormOut.resetFields();
        this.$refs.multipleFormIn1.resetFields();
        this.$refs.multipleFormIn2.resetFields();
      },
      removeDomain(item) {
        var index = this.dynamicValidateForm.domains.indexOf(item)
        if (index !== -1) {
          this.dynamicValidateForm.domains.splice(index, 1)
        }
      },
      addDomain() {
        this.dynamicValidateForm.domains.push({
          value: '',
          key: Date.now()
        });
      }
    },
    computed: {
      rules () {
        return {
          name: [
            { required: true, message: this.$t('name'), trigger: 'blur' },
            { min: 3, max: 5, message: '长度在 3 到 5 个字符', trigger: 'blur' }
          ],
          region: [
            { required: true, message: '请选择活动区域', trigger: 'change' }
          ],
          date1: [
            { type: 'date', required: true, message: '请选择日期', trigger: 'change' }
          ],
          date2: [
            { type: 'date', required: true, message: '请选择时间', trigger: 'change' }
          ],
          type: [
            { type: 'array', required: true, message: '请至少选择一个活动性质', trigger: 'change' }
          ],
          resource: [
            { required: true, message: '请选择活动资源', trigger: 'change' }
          ],
          desc: [
            { required: true, message: '请填写活动形式', trigger: 'blur' }
          ]
        }
      }
      // rules2 () {
      //   var validatePass = (rule, value, callback) => {
      //     if (value === '') {
      //       callback(new Error('请输入密码'));
      //     } else {
      //       if (this.ruleForm2.checkPass !== '') {
      //         this.$refs.ruleForm2.validateField('checkPass');
      //       }
      //       callback();
      //     }
      //   };
      //   var validatePass2 = (rule, value, callback) => {
      //     if (value === '') {
      //       callback(new Error('请再次输入密码'));
      //     } else if (value !== this.ruleForm2.pass) {
      //       callback(new Error('两次输入密码不一致!'));
      //     } else {
      //       callback();
      //     }
      //   };
      //   var checkAge = (rule, value, callback) => {
      //     if (!value) {
      //       return callback(new Error(this.$t('name')));
      //     }
      //     setTimeout(() => {
      //       if (!Number.isInteger(value)) {
      //         callback(new Error('请输入数字值'));
      //       } else {
      //         if (value < 18) {
      //           callback(new Error('必须年满18岁'));
      //         } else {
      //           callback();
      //         }
      //       }
      //     }, 1000);
      //   };
      //   return {
      //     pass: [
      //       { validator: validatePass, trigger: 'blur' }
      //     ],
      //     checkPass: [
      //       { validator: validatePass2, trigger: 'blur' }
      //     ],
      //     age: [
      //       { validator: checkAge, trigger: 'blur, change' }
      //     ]
      //   }
      // }
    },
    locales: {
      'en': {
        name: 'Please input the name of activity',
        blur: 'blur'
      },
      'zh-cn': {
        name: '请输入活动名称',
        blur: 'blur'
      }
    },
    created () {
      Vue.config.lang = this.lang;
    }
  }
</script>

<style>
  .demo-form.demo-zh-CN {
    .el-select .el-input {
      width: 380px;
    }
    .el-form {
      width: 460px;
    }

    .line {
      text-align: center;
    }

    .el-checkbox-group {
      width: 100%;
      margin: 0;
      padding: 0;
      list-style: none;

      &:after, &:before {
        content: ' ';
        display: table;
      }
      &:after {
        clear: both;
        visibility: hidden;
        font-size: 0;
        height: 0;
      }

      .el-checkbox {
        float: left;
        width: 160px;
        padding-right: 20px;
        margin: 0;
        padding: 0;

        + .el-checkbox {
          margin-left: 0;
        }
      }
    }
    .demo-form-normal {
      width: 460px;
    }
    .demo-form-inline {
      width: auto;
      text-align: right;

      .el-input {
        width: 150px;
      }
      > * {
        margin-right: 10px;
      }
    }
    .demo-ruleForm {
      width: 460px;
      margin-top:15px;

      .el-select .el-input {
        width: 360px;
      }
      &.border-form {
        width: initial;
      }
    }
    .border-form {
      padding: 10px;
      border: 1px solid #ebebeb;
    }
    .demo-dynamic {
      .el-input {
        margin-right: 10px;
        width: 270px;
        vertical-align: top;
      }
    }
    .fr {
      float: right;
    }
    .txt-center{
      text-align: center;
    }
  }
</style>

## Form 表单

:::tip 
新规范调整内容：
* ##### 默认label位置调整为top，默认 form-item上下间距由原来的30px调整为10px

注意修改事项：
* ##### 设计稿如果不是top位置的label需要和设计师按照规范二次确认。
* ##### 最后一个form-item的margin-bottom强制设置为0.
:::


由输入框、选择器、单选框、多选框等控件组成，用以收集、校验、提交数据

在el-form上设置size，el-button用el-form-item包起来，就会继承el-form上设置的size的值，这样就不用再单独对button设置size。
但和设计师之间约定好的规范，是页面级的表单，按钮是居中显示，所以还是不要包在el-form-item中。


### 典型表单

包括各种表单项，比如输入框、选择器、开关、单选框、多选框等。

:::demo 在 Form 组件中，每一个表单域由一个 Form-Item 组件构成，表单域中可以放置各种类型的表单控件，包括 Input、Select、Checkbox、Radio、Switch、DatePicker、TimePicker
```html
<el-form
  :use-action="true"
  :action="'/sss/s'"
  :method="'POST'"
  ref="formAction"
  :model="form"
  size="medium"
  label-width="80px">
  <el-form-item>
    <span slot="label" class="withIconLabel"><span>活动名称</span><i class="el-ksd-icon-help_with_border_16"></i></span>
    <el-input v-model.trim="form.name"></el-input>
  </el-form-item>
  <el-form-item label="活动区域">
    <el-select v-model="form.region" placeholder="请选择活动区域" :disabled="form.delivery">
      <el-option label="区域一" value="shanghai"></el-option>
      <el-option label="区域二" value="beijing"></el-option>
    </el-select>
  </el-form-item>
  <el-form-item label="活动时间">
    <el-col :span="11">
      <el-date-picker type="date" placeholder="选择日期" v-model="form.date1" style="width: 100%;"></el-date-picker>
    </el-col>
    <el-col class="line" :span="2">-</el-col>
    <el-col :span="11">
      <el-time-picker type="fixed-time" placeholder="选择时间" v-model="form.date2" style="width: 100%;"></el-time-picker>
    </el-col>
  </el-form-item>
  <el-form-item label="即时配送">
    <el-switch v-model="form.delivery"></el-switch>
  </el-form-item>
  <el-form-item label="活动性质">
    <el-checkbox-group v-model="form.type">
      <el-checkbox label="美食/餐厅线上活动" name="type"></el-checkbox>
      <el-checkbox label="地推活动" name="type"></el-checkbox>
      <el-checkbox label="线下主题活动" name="type"></el-checkbox>
      <el-checkbox label="单纯品牌曝光" name="type"></el-checkbox>
    </el-checkbox-group>
  </el-form-item>
  <el-form-item label="特殊资源">
    <el-radio-group v-model="form.resource">
      <el-radio label="线上品牌商赞助"></el-radio>
      <el-radio label="线下场地免费"></el-radio>
    </el-radio-group>
  </el-form-item>
  <el-form-item label="活动形式">
    <el-input type="textarea" v-model.trim="form.desc"></el-input>
  </el-form-item>
  <p class="txt-center">
    <el-button size="medium">取消</el-button>
    <el-button size="medium" type="primary" @click="submitFormWithAction">立即创建</el-button>
  </p>
</el-form>
<script>
  export default {
    data() {
      return {
        form: {
          name: '',
          region: '',
          date1: '',
          date2: '',
          delivery: false,
          type: [],
          resource: '',
          desc: ''
        }
      }
    },
    methods: {
      onSubmit() {
        console.log('submit!');
      },
      submitFormWithAction () { // 启用原生提交时，用这种方式提交
        this.$refs.formAction.$el.submit()
      }
    }
  }
</script>
```
:::

:::tip
W3C 标准中有如下[规定](https://www.w3.org/MarkUp/html-spec/html-spec_8.html#SEC8.2)：
> <i>When there is only one single-line text input field in a form, the user agent should accept Enter in that field as a request to submit the form.</i>

即：当一个 form 元素中只有一个输入框时，在该输入框中按下回车应提交该表单。如果希望阻止这一默认行为，可以在 `<el-form>` 标签上添加 `@submit.native.prevent`。
:::

### 行内表单

当垂直方向空间受限且表单较简单时，可以在一行内放置表单。
一般列表页表头上方查询选项的地方，基本是单行的，可以采用这种排布。查询按钮省略，搜索框，默认enter键查询，并且加trim处理，下拉或者日期控件类，change时便查询。

:::demo 设置 `inline` 属性可以让表单域变为行内的表单域.
```html
<el-form :inline="true" :model="formInline" size="medium" class="demo-form-inline">
  <el-form-item>
    <el-input v-model.trim="formInline.clusterName" 
              prefix-icon="el-icon-search" 
              placeholder="搜索集群名称" 
              @keyup.enter.native="onSubmit()"></el-input>
  </el-form-item>
  <el-form-item>
    <el-date-picker
      v-model="formInline.startDate"
      type="date"
      placeholder="选择日期"
      @change="onSubmit()">
    </el-date-picker>
    -
    <el-date-picker
      v-model="formInline.endDate"
      type="date"
      placeholder="选择日期"
      @change="onSubmit()">
    </el-date-picker>
  </el-form-item>
</el-form>
<script>
  export default {
    data() {
      return {
        formInline: {
          clusterName: '',
          startDate: '',
          endDate: ''
        }
      }
    },
    methods: {
      onSubmit() {
        console.log('submit!');
      }
    }
  }
</script>
```
:::

### 对齐方式

根据具体目标和制约因素，选择最佳的标签对齐方式，暂时项目中比较普遍的基本是底部对齐居多，其次是右对齐，最后是左对齐。

:::demo 通过设置 `label-position` 属性可以改变表单域标签的位置，可选值为 `top`、`left`，当设为 `top` 时标签会置于表单域的顶部
```html
<el-radio-group v-model="labelPosition">
  <el-radio-button label="top">顶部对齐</el-radio-button>
  <el-radio-button label="right">右对齐</el-radio-button>
  <el-radio-button label="left">左对齐</el-radio-button>
</el-radio-group>
<div style="margin: 20px;"></div>
<el-form :label-position="labelPosition" size="medium" label-width="80px" :model="formLabelAlign">
  <el-form-item>
    <span slot="label" class="withIconLabel"><span>名称</span><i class="el-ksd-icon-help_with_border_16"></i></span>
    <el-input v-model.trim="formLabelAlign.name"></el-input>
  </el-form-item>
  <el-form-item label="活动区域">
    <el-input v-model.trim="formLabelAlign.region"></el-input>
  </el-form-item>
  <el-form-item label="活动形式">
    <el-input v-model.trim="formLabelAlign.type"></el-input>
  </el-form-item>
  <p class="txt-center">
    <el-button size="medium">取消</el-button>
    <el-button size="medium" type="primary" @click="onSubmit">立即创建</el-button>
  </p>
</el-form>
<script>
  export default {
    data() {
      return {
        labelPosition: 'top',
        formLabelAlign: {
          name: '',
          region: '',
          type: ''
        }
      };
    }
  }
</script>
```
:::

### 表单验证

在防止用户犯错的前提下，尽可能让用户更早地发现并纠正错误。

:::demo Form 组件提供了表单验证的功能，只需要通过 `rules` 属性传入约定的验证规则，并 Form-Item 的 `prop` 属性设置为需校验的字段名即可。校验规则参见 [async-validator](https://github.com/yiminghe/async-validator)
```html
<el-button-group>
  <el-button size="medium" round @click="changeLang('en')" :class="{'active':lang=='en'}">EN</el-button>
  <el-button size="medium" round @click="changeLang('zh-cn')" :class="{'active':lang=='zh-cn'}">中文</el-button>
</el-button-group>

<el-form :model="ruleForm" label-position="left" :rules="rules" ref="ruleForm" size="medium" label-width="100px" class="demo-ruleForm" :scroll-offset="-80">
  <el-form-item label="活动名称" prop="name">
    <el-input v-model.trim="ruleForm.name"></el-input>
  </el-form-item>
  <el-form-item label="活动区域" prop="region">
    <el-select v-model="ruleForm.region" placeholder="请选择活动区域">
      <el-option label="区域一" value="shanghai"></el-option>
      <el-option label="区域二" value="beijing"></el-option>
    </el-select>
  </el-form-item>
  <el-form-item label="活动时间" required>
    <el-col :span="11">
      <el-form-item prop="date1">
        <el-date-picker type="date" placeholder="选择日期" v-model="ruleForm.date1" style="width: 100%;"></el-date-picker>
      </el-form-item>
    </el-col>
    <el-col class="line" :span="2">-</el-col>
    <el-col :span="11">
      <el-form-item prop="date2">
        <el-time-picker type="fixed-time" placeholder="选择时间" v-model="ruleForm.date2" style="width: 100%;"></el-time-picker>
      </el-form-item>
    </el-col>
  </el-form-item>
  <el-form-item label="即时配送" prop="delivery">
    <el-switch v-model="ruleForm.delivery"></el-switch>
  </el-form-item>
  <el-form-item label="活动性质" prop="type">
    <el-checkbox-group v-model="ruleForm.type">
      <el-checkbox label="美食/餐厅线上活动" name="type"></el-checkbox>
      <el-checkbox label="地推活动" name="type"></el-checkbox>
      <el-checkbox label="线下主题活动" name="type"></el-checkbox>
      <el-checkbox label="单纯品牌曝光" name="type"></el-checkbox>
    </el-checkbox-group>
  </el-form-item>
  <el-form-item label="特殊资源" prop="resource">
    <el-radio-group v-model="ruleForm.resource">
      <el-radio label="线上品牌商赞助"></el-radio>
      <el-radio label="线下场地免费"></el-radio>
    </el-radio-group>
  </el-form-item>
  <el-form-item label="活动形式" prop="desc">
    <el-input type="textarea" v-model.trim="ruleForm.desc"></el-input>
  </el-form-item>
  <p class="txt-center">
    <el-button size="medium" @click="resetForm('ruleForm')">重置</el-button>
    <el-button size="medium" type="primary" @click="submitForm('ruleForm')">立即创建</el-button>
  </p>
</el-form>
<script>
  export default {
    data() {
      return {
        lang: 'zh-cn',
        ruleForm: {
          name: '',
          region: '',
          date1: '',
          date2: '',
          delivery: false,
          type: [],
          resource: '',
          desc: ''
        }
        // ,
        // rules: {
        //   name: [
        //     { required: true, message: '请输入活动名称', trigger: 'blur' },
        //     { min: 3, max: 5, message: '长度在 3 到 5 个字符', trigger: 'blur' }
        //   ],
        //   region: [
        //     { required: true, message: '请选择活动区域', trigger: 'change' }
        //   ],
        //   date1: [
        //     { type: 'date', required: true, message: '请选择日期', trigger: 'change' }
        //   ],
        //   date2: [
        //     { type: 'date', required: true, message: '请选择时间', trigger: 'change' }
        //   ],
        //   type: [
        //     { type: 'array', required: true, message: '请至少选择一个活动性质', trigger: 'change' }
        //   ],
        //   resource: [
        //     { required: true, message: '请选择活动资源', trigger: 'change' }
        //   ],
        //   desc: [
        //     { required: true, message: '请填写活动形式', trigger: 'blur' }
        //   ]
        // }
      };
    },
    methods: {
      changeLang (lang) {
        this.lang = lang;
        Vue.config.lang = lang;
      },
      submitForm(formName) {
        this.$refs[formName].validate((valid) => {
          if (valid) {
            alert('submit!');
          } else {
            console.log('error submit!!');
            return false;
          }
        });
      },
      resetForm(formName) {
        this.$refs[formName].resetFields();
      }
    },
    computed: {
      rules () {
        return {
          name: [
            { required: true, message: this.$t('name'), trigger: 'blur' },
            { min: 3, max: 5, message: '长度在 3 到 5 个字符', trigger: 'blur' }
          ],
          region: [
            { required: true, message: '请选择活动区域', trigger: 'change' }
          ],
          date1: [
            { type: 'date', required: true, message: '请选择日期', trigger: 'change' }
          ],
          date2: [
            { type: 'date', required: true, message: '请选择时间', trigger: 'change' }
          ],
          type: [
            { type: 'array', required: true, message: '请至少选择一个活动性质', trigger: 'change' }
          ],
          resource: [
            { required: true, message: '请选择活动资源', trigger: 'change' }
          ],
          desc: [
            { required: true, message: '请填写活动形式', trigger: 'blur' }
          ]
        }
      }
    },
    locales: {
      'en': {
        name: 'Please input the name of activity'
      },
      'zh-cn': {
        name: '请输入活动名称'
      }
    }
  }
</script>
```
:::

:::tip
当在多语言环境时，表单验证的错误信息是不能跟着切换的，这时候需要把rules从data挪到computed里面
```js
  data() {
      return {
        // rules: {
        //   name: [
        //     { required: true, message: '请输入活动名称', trigger: 'blur' },
        //     { min: 3, max: 5, message: '长度在 3 到 5 个字符', trigger: 'blur' }
        //   ],
        //   region: [
        //     { required: true, message: '请选择活动区域', trigger: 'change' }
        //   ],
        //   date1: [
        //     { type: 'date', required: true, message: '请选择日期', trigger: 'change' }
        //   ],
        //   date2: [
        //     { type: 'date', required: true, message: '请选择时间', trigger: 'change' }
        //   ],
        //   type: [
        //     { type: 'array', required: true, message: '请至少选择一个活动性质', trigger: 'change' }
        //   ],
        //   resource: [
        //     { required: true, message: '请选择活动资源', trigger: 'change' }
        //   ],
        //   desc: [
        //     { required: true, message: '请填写活动形式', trigger: 'blur' }
        //   ]
        // }
      };
    },
    computed: {
      rules () {
        return {
          name: [
            { required: true, message: this.$t('name'), trigger: 'blur' },
            { min: 3, max: 5, message: '长度在 3 到 5 个字符', trigger: 'blur' }
          ],
          region: [
            { required: true, message: '请选择活动区域', trigger: 'change' }
          ],
          date1: [
            { type: 'date', required: true, message: '请选择日期', trigger: 'change' }
          ],
          date2: [
            { type: 'date', required: true, message: '请选择时间', trigger: 'change' }
          ],
          type: [
            { type: 'array', required: true, message: '请至少选择一个活动性质', trigger: 'change' }
          ],
          resource: [
            { required: true, message: '请选择活动资源', trigger: 'change' }
          ],
          desc: [
            { required: true, message: '请填写活动形式', trigger: 'blur' }
          ]
        }
      }
    }
  }
```
:::



### 自定义校验规则

这个例子中展示了:

(1)异步验证邮箱是否存在（目标邮箱以：demo@kyligence.io）

(2)如何使用自定义验证规则来完成密码的二次验证

:::demo 本例还使用`status-icon`属性为输入框添加了表示校验结果的反馈图标。
```html
<el-button-group>
  <el-button size="medium" round @click="changeLang('en')" :class="{'active':lang=='en'}">EN</el-button>
  <el-button size="medium" round @click="changeLang('zh-cn')" :class="{'active':lang=='zh-cn'}">中文</el-button>
</el-button-group>
<el-form :model="ruleForm2" status-icon :rules="rules2" ref="ruleForm2" label-width="100px" class="demo-ruleForm" :scroll-offset="-80">
  <el-form-item label="邮箱" prop="email">
    <el-input v-model.trim="ruleForm2.email"></el-input>
  </el-form-item>
  <el-form-item label="密码" prop="pass">
    <el-input type="password" v-model.trim="ruleForm2.pass" auto-complete="off"></el-input>
  </el-form-item>
  <el-form-item label="确认密码" prop="checkPass">
    <el-input type="password" v-model.trim="ruleForm2.checkPass" auto-complete="off"></el-input>
  </el-form-item>
  <p class="txt-center">
    <el-button size="medium" @click="resetForm('ruleForm2')">重置</el-button>
    <el-button size="medium" type="primary" @click="submitForm('ruleForm2')">提交</el-button>
  </p>
</el-form>
<script>
  export default {
    data() {
      var checkEmail = (rule, value, callback) => {
        if (!value) {
          return callback(new Error('邮箱不能为空'));
        }
        setTimeout(() => { // 模拟异步请求
          if (value !== 'demo@kyligence.io') {
            callback(new Error('重置密码的目标邮箱不正确'));
          } else {
            callback();
          }
        }, 1000);
      };
      var validatePass = (rule, value, callback) => {
        if (value === '') {
          callback(new Error('请输入密码'));
        } else {
          if (this.ruleForm2.checkPass !== '') {
            this.$refs.ruleForm2.validateField('checkPass');
          }
          callback();
        }
      };
      var validatePass2 = (rule, value, callback) => {
        if (value === '') {
          callback(new Error('请再次输入密码'));
        } else if (value !== this.ruleForm2.pass) {
          callback(new Error('两次输入密码不一致!'));
        } else {
          callback();
        }
      };
      return {
        ruleForm2: {
          pass: '',
          checkPass: '',
          email: ''
        },
        rules2: {
          pass: [
            { validator: validatePass, trigger: 'blur' }
          ],
          checkPass: [
            { validator: validatePass2, trigger: 'blur' }
          ],
          age: [
            { validator: checkEmail, trigger: 'blur' }
          ]
        }
      };
    },
    methods: {
      submitForm(formName) {
        this.$refs[formName].validate((valid) => {
          if (valid) {
            alert('submit!');
          } else {
            console.log('error submit!!');
            return false;
          }
        });
      },
      resetForm(formName) {
        this.$refs[formName].resetFields();
      }
    }
  }
</script>
```
:::

### 动态增减表单项

:::demo 除了在 Form 组件上一次性传递所有的验证规则外还可以在单个的表单域上传递属性的验证规则
```html
<el-form :model="dynamicValidateForm" size="medium" ref="dynamicValidateForm" label-width="100px" class="demo-dynamic">
  <el-form-item
    prop="email"
    label="邮箱"
    :rules="[
      { required: true, message: '请输入邮箱地址', trigger: 'blur' },
      { type: 'email', message: '请输入正确的邮箱地址', trigger: 'blur,change' }
    ]"
  >
    <el-input v-model.trim="dynamicValidateForm.email"></el-input>
  </el-form-item>
  <el-form-item
    v-for="(domain, index) in dynamicValidateForm.domains"
    :label="'域名' + index"
    :key="domain.key"
    :prop="'domains.' + index + '.value'"
    :rules="{
      required: true, message: '域名不能为空', trigger: 'blur'
    }"
  >
    <el-input v-model.trim="domain.value"></el-input><el-button @click.prevent="removeDomain(domain)">删除</el-button>
  </el-form-item>
  <p class="txt-center">
    <el-button size="medium" @click="resetForm('dynamicValidateForm')">重置</el-button>
    <el-button size="medium" @click="addDomain">新增域名</el-button>
    <el-button size="medium" type="primary" @click="submitForm('dynamicValidateForm')">提交</el-button>
  </p>
</el-form>
<script>
  export default {
    data() {
      return {
        dynamicValidateForm: {
          domains: [{
            value: ''
          }],
          email: ''
        }
      };
    },
    methods: {
      submitForm(formName) {
        this.$refs[formName].validate((valid) => {
          if (valid) {
            alert('submit!');
          } else {
            console.log('error submit!!');
            return false;
          }
        });
      },
      resetForm(formName) {
        this.$refs[formName].resetFields();
      },
      removeDomain(item) {
        var index = this.dynamicValidateForm.domains.indexOf(item)
        if (index !== -1) {
          this.dynamicValidateForm.domains.splice(index, 1)
        }
      },
      addDomain() {
        this.dynamicValidateForm.domains.push({
          value: '',
          key: Date.now()
        });
      }
    }
  }
</script>
```
:::

### 数字类型验证

:::demo 数字类型的验证需要在 `v-model` 处加上 `.number` 的修饰符，这是 `Vue` 自身提供的用于将绑定值转化为 `number` 类型的修饰符。
```html
<el-form :model="numberValidateForm" size="medium" ref="numberValidateForm" label-width="100px" class="demo-ruleForm">
  <el-form-item
    label="年龄"
    prop="age"
    :rules="[
      { required: true, message: '年龄不能为空'},
      { type: 'number', message: '年龄必须为数字值'}
    ]"
  >
    <el-input type="age" v-model.number="numberValidateForm.age" auto-complete="off"></el-input>
  </el-form-item>
  <p class="txt-center">
    <el-button size="medium" @click="resetForm('numberValidateForm')">重置</el-button>
    <el-button size="medium" type="primary" @click="submitForm('numberValidateForm')">提交</el-button>
  </p>
</el-form>
<script>
  export default {
    data() {
      return {
        numberValidateForm: {
          age: ''
        }
      };
    },
    methods: {
      submitForm(formName) {
        this.$refs[formName].validate((valid) => {
          if (valid) {
            alert('submit!');
          } else {
            console.log('error submit!!');
            return false;
          }
        });
      },
      resetForm(formName) {
        this.$refs[formName].resetFields();
      }
    }
  }
</script>
```
:::

:::tip
嵌套在 `el-form-item` 中的 `el-form-item` 标签宽度默认为零，不会继承 `el-form` 的 `label-width`。如果需要可以为其单独设置 `label-width` 属性。
:::

### 表单内组件尺寸控制

通过设置 Form 上的 `size` 属性可以使该表单内所有可调节大小的组件继承该尺寸。Form-Item 也具有该属性。

:::demo 如果希望某个表单项或某个表单组件的尺寸不同于 Form 上的`size`属性，直接为这个表单项或表单组件设置自己的`size`即可。比如下面例子上的按钮，不同于el-form上设置的size，固定设置成large。
```html

<el-radio-group v-model="formSize">
  <el-radio-button label="">default</el-radio-button>
  <el-radio-button label="medium">medium</el-radio-button>
  <el-radio-button label="small">small</el-radio-button>
  <el-radio-button label="mini">mini</el-radio-button>
</el-radio-group>

<el-form ref="form" :model="sizeForm" label-width="80px" :size="formSize" style="margin-top:15px">
  <el-form-item>
    <span slot="label" class="withIconLabel"><span>活动名称</span><i class="el-ksd-icon-help_with_border_16"></i></span>
    <el-input v-model.trim="sizeForm.name"></el-input>
  </el-form-item>
  <el-form-item label="活动区域">
    <el-select v-model="sizeForm.region" placeholder="请选择活动区域">
      <el-option label="区域一" value="shanghai"></el-option>
      <el-option label="区域二" value="beijing"></el-option>
    </el-select>
  </el-form-item>
  <el-form-item label="活动时间">
    <el-col :span="11">
      <el-date-picker type="date" placeholder="选择日期" v-model="sizeForm.date1" style="width: 100%;"></el-date-picker>
    </el-col>
    <el-col class="line" :span="2">-</el-col>
    <el-col :span="11">
      <el-time-picker type="fixed-time" placeholder="选择时间" v-model="sizeForm.date2" style="width: 100%;"></el-time-picker>
    </el-col>
  </el-form-item>
  <el-form-item label="活动性质">
    <el-checkbox-group v-model="sizeForm.type">
      <el-checkbox-button label="美食/餐厅线上活动" name="type"></el-checkbox-button>
      <el-checkbox-button label="地推活动" name="type"></el-checkbox-button>
      <el-checkbox-button label="线下主题活动" name="type"></el-checkbox-button>
    </el-checkbox-group>
  </el-form-item>
  <el-form-item label="特殊资源" size="large">
    <el-radio-group v-model="sizeForm.resource">
      <el-radio border label="线上品牌商赞助"></el-radio>
      <el-radio border label="线下场地免费"></el-radio>
    </el-radio-group>
  </el-form-item>
  <p class="txt-center">
    <el-button size="medium">取消</el-button>
    <el-button size="medium" type="primary" @click="onSubmit">立即创建</el-button>
  </p>
</el-form>

<script>
  export default {
    data() {
      return {
        sizeForm: {
          name: '',
          region: '',
          date1: '',
          date2: '',
          delivery: false,
          type: [],
          resource: '',
          desc: ''
        }
      };
    },
    methods: {
      onSubmit() {
        console.log('submit!');
      }
    }
  };
</script>
```
:::

### 多表单，嵌套表单验证锁定

当多个表单存在于同一个页面且同时验证，自动报错定位只会定位最后一个form中的结果。为了避免定位结果没有自上而下的情况，可以给多个表单设置同一个group-name，就可以通过group来定位一组报错。

:::demo 传入group-name来设置同一组form的报错定位。scroll-offset用于定位偏移，正数向下偏移，负数向上偏移。
```html
<el-button-group>
  <el-button size="medium" round @click="changeLang('en')" :class="{'active':lang=='en'}">EN</el-button>
  <el-button size="medium" round @click="changeLang('zh-cn')" :class="{'active':lang=='zh-cn'}">中文</el-button>
</el-button-group>
<p class="txt-center">
    <el-button size="medium" @click="resetForm2()">重置</el-button>
    <el-button size="medium" type="primary" @click="submitForm2()">立即创建</el-button>
  </p>
<!-- 外层form -->
<el-form :model="multipleFormOut" :rules="rules" ref="multipleFormOut" size="medium" label-width="100px" class="demo-ruleForm border-form" group-name="multipleForm" :scroll-offset="-80">
  <div>外层form</div>
  <!-- 嵌套form1 -->
  <el-form :model="multipleFormIn1" :rules="rules" ref="multipleFormIn1" size="medium" label-width="100px" class="demo-ruleForm border-form" group-name="multipleForm" :scroll-offset="-80">
    <div>嵌套form1</div>
    <el-form-item label="活动名称" prop="name">
      <el-input v-model.trim="multipleFormIn1.name"></el-input>
    </el-form-item>
    <div style="height: 100px;"></div>

    <!-- 嵌套form2 -->
    <el-form :model="multipleFormIn2" :rules="rules" ref="multipleFormIn2" size="medium" label-width="100px" class="demo-ruleForm border-form" group-name="multipleForm" :scroll-offset="-80">
      <div>嵌套form2</div>
      <el-form-item label="活动名称" prop="name">
        <el-input v-model.trim="multipleFormIn2.name"></el-input>
      </el-form-item>
      <el-form-item label="活动区域" prop="region">
        <el-select v-model="multipleFormIn2.region" placeholder="请选择活动区域">
          <el-option label="区域一" value="shanghai"></el-option>
          <el-option label="区域二" value="beijing"></el-option>
        </el-select>
      </el-form-item>
    </el-form>

    <el-form-item label="活动区域" prop="region">
      <el-select v-model="multipleFormIn1.region" placeholder="请选择活动区域">
        <el-option label="区域一" value="shanghai"></el-option>
        <el-option label="区域二" value="beijing"></el-option>
      </el-select>
    </el-form-item>
  </el-form>

  <div style="height: 100px;"></div>
  <el-form-item label="活动名称" prop="name">
    <el-input v-model.trim="multipleFormOut.name"></el-input>
  </el-form-item>
  <el-form-item label="活动区域" prop="region">
    <el-select v-model="multipleFormOut.region" placeholder="请选择活动区域">
      <el-option label="区域一" value="shanghai"></el-option>
      <el-option label="区域二" value="beijing"></el-option>
    </el-select>
  </el-form-item>
</el-form>
<script>
  export default {
    data() {
      return {
        lang: 'zh-cn',
        multipleFormOut: {
          name: '',
          region: ''
        },
        multipleFormIn1: {
          name: '',
          region: ''
        },
        multipleFormIn2: {
          name: '',
          region: ''
        }
      };
    },
    methods: {
      changeLang (lang) {
        this.lang = lang;
        Vue.config.lang = lang;
      },
      submitForm2() {
        this.$refs.multipleFormOut.validate((isFormOutValid) => {
          this.$refs.multipleFormIn1.validate((isFormIn1Valid) => {
            this.$refs.multipleFormIn2.validate((isFormIn1Valid) => {
              if (isFormOutValid && isFormIn1Valid) {
                alert('submit!');
              } else {
                console.log('error submit!!');
                return false;
              }
            });
          });
        });
      },
      resetForm2() {
        this.$refs.multipleFormOut.resetFields();
        this.$refs.multipleFormIn1.resetFields();
        this.$refs.multipleFormIn2.resetFields();
      }
    },
    computed: {
      rules () {
        return {
          name: [
            { required: true, message: this.$t('name'), trigger: 'blur' },
            { min: 3, max: 5, message: '长度在 3 到 5 个字符', trigger: 'blur' }
          ],
          region: [
            { required: true, message: '请选择活动区域', trigger: 'change' }
          ]
        }
      }
    },
    locales: {
      'en': {
        name: 'Please input the name of activity'
      },
      'zh-cn': {
        name: '请输入活动名称'
      }
    }
  }
</script>
```
:::

### Form Attributes

| 参数      | 说明          | 类型      | 可选值                           | 默认值  |
|---------- |-------------- |---------- |--------------------------------  |-------- |
| model   | 表单数据对象 | object      |                  —                |  — |
| rules    | 表单验证规则 | object | — | — |
| inline    | 行内表单模式 | boolean | — | false |
| label-position | 表单域标签的位置 | string |  right/left/top            | right |
| label-width | 表单域标签的宽度，作为 Form 直接子元素的 form-item 会继承该值 | string | — | — |
| label-suffix | 表单域标签的后缀 | string | — | — |
| show-message  | 是否显示校验错误信息 | boolean | — | true |
| inline-message  | 是否以行内形式展示校验信息 | boolean | — | false |
| status-icon  | 是否在输入框中显示校验结果反馈图标 | boolean | — | false |
| validate-on-rule-change  | 是否在 `rules` 属性改变后立即触发一次验证 | boolean | — | true |
| size  | 用于控制该表单内组件的尺寸 | string | medium / small / mini | — |
| disabled | 是否禁用该表单内的所有组件。若设置为 true，则表单内组件上的 disabled 属性不再生效 | boolean | — | false |
| group-name | 设置多个form为一组报错定位 | string | — | - |
| scroll-offset | 设置form报错定位的偏移 | number | — | 0 |
| useAction | 控制是否启用 form 的原生 submit 操作 | boolean | - | false |
| action | form 原生属性，请求地址 | string | - | - |
| method | form 原生属性，请求方法 | string | get/post | - |

### Form Methods

| 方法名      | 说明          | 参数
|---------- |-------------- | --------------
| validate | 对整个表单进行校验的方法。若不传入回调函数，则会返回一个 promise | Function(callback: Function(boolean))
| validateField | 对部分表单字段进行校验的方法 | Function(prop: string, callback: Function(errorMessage: string))
| resetFields | 对整个表单进行重置，将所有字段值重置为初始值并移除校验结果 | -
| clearValidate | 移除整个表单的校验结果 | -

### Form-Item Attributes

| 参数      | 说明          | 类型      | 可选值                           | 默认值  |
|---------- |-------------- |---------- |--------------------------------  |-------- |
| prop    | 表单域 model 字段，在使用 validate、resetFields 方法的情况下，该属性是必填的 | string    | 传入 Form 组件的 `model` 中的字段 | — |
| label | 标签文本 | string | — | — |
| label-width | 表单域标签的的宽度，例如 '50px' | string |       —       | — |
| required | 是否必填，如不设置，则会根据校验规则自动生成 | bolean | — | false |
| rules    | 表单验证规则 | object | — | — |
| error    | 表单域验证错误信息, 设置该值会使表单验证状态变为`error`，并显示该错误信息 | string | — | — |
| show-message  | 是否显示校验错误信息 | boolean | — | true |
| inline-message  | 以行内形式展示校验信息 | boolean | — | false |
| size  | 用于控制该表单域下组件的尺寸 | string | medium / small / mini | - |

### Form-Item Slot
| name | 说明 |
|------|--------|
| — | Form Item 的内容 |
| label | 标签文本的内容 |

### Form-Item Methods

| 方法名      | 说明          | 参数
|---------- |-------------- | --------------
| resetField | 对该表单项进行重置，将其值重置为初始值并移除校验结果 | -
