<template>
  <form
    :action="useAction ? action : ''"
    :method="useAction ? method : ''"
    class="el-form"
    :class="[
    labelPosition ? 'el-form--label-' + labelPosition : '',
    { 'el-form--inline': inline }
  ]">
    <slot></slot>
  </form>
</template>
<script>
  import {
    getScrollableAncestor,
    animationScroll,
    createGroupFormValidateInfo,
    destroyGroupFormValidateInfo,
    cleanupGroupFormsValidateInfo,
    checkIsShouldScroll
} from './util';

  export default {
    name: 'ElForm',

    componentName: 'ElForm',

    provide() {
      return {
        elForm: this
      };
    },

    props: {
      useAction: {
        type: Boolean,
        default: false
      },
      action: {
        type: String,
        default: ''
      },
      method: {
        type: String,
        default: ''
      },
      model: Object,
      rules: Object,
      labelPosition: {
        type: String,
        default: 'top'
      },
      labelWidth: String,
      labelSuffix: {
        type: String,
        default: ''
      },
      inline: Boolean,
      inlineMessage: Boolean,
      statusIcon: Boolean,
      showMessage: {
        type: Boolean,
        default: true
      },
      size: String,
      disabled: Boolean,
      validateOnRuleChange: {
        type: Boolean,
        default: false
      },
      validateErrorFieldOnRuleChange: {
        type: Boolean,
        default: true
      },
      groupName: {
        type: String
      },
      scrollOffset: {
        type: Number,
        default: 0
      }
    },
    watch: {
      rules() {
        if (this.validateOnRuleChange) {
          this.validate(() => {});
        }
        if (this.validateErrorFieldOnRuleChange) {
          this.fields.forEach((field, index) => {
            if (field.validateState === 'error') {
              field.validate('');
            }
          });
        }
      },
      '$lang': function(val) {
        this.fields.forEach((field, index) => {
          if (field.validateState === 'error') {
            field.validate('');
          }
        });
      }
    },
    data() {
      return {
        fields: [],
        formId: null
      };
    },
    created() {
      this.$on('el.form.addField', (field) => {
        if (field) {
          this.fields.push(field);
        }
      });
      /* istanbul ignore next */
      this.$on('el.form.removeField', (field) => {
        if (field.prop) {
          this.fields.splice(this.fields.indexOf(field), 1);
        }
      });

      // 如果form被分组
      createGroupFormValidateInfo(this.groupName, formId => (this.formId = formId));
    },
    beforeDestroy() {
      destroyGroupFormValidateInfo(this.groupName, this.formId);
    },
    methods: {
      resetFields() {
        if (!this.model) {
          process.env.NODE_ENV !== 'production' &&
          console.warn('[Element Warn][Form]model is required for resetFields to work.');
          return;
        }
        this.fields.forEach(field => {
          field.resetField();
        });
      },
      clearValidate() {
        this.fields.forEach(field => {
          field.clearValidate();
        });
      },
      validate(callback) {
        if (!this.model) {
          console.warn('[Element Warn][Form]model is required for validate to work!');
          return;
        }

        let promise;
        // if no callback, return promise
        if (typeof callback !== 'function' && window.Promise) {
          promise = new window.Promise((resolve, reject) => {
            callback = function(valid) {
              valid ? resolve(valid) : reject(valid);
            };
          });
        }

        let valid = true;
        let count = 0;
        let errorField = null;
        // 如果需要验证的fields为空，调用验证时立刻返回callback
        if (this.fields.length === 0 && callback) {
          callback(true);
        }
        this.fields.forEach((field, index) => {
          field.validate('', errors => {
            if (errors) {
              valid = false;
              !errorField && (errorField = field);
            }
            if (typeof callback === 'function' && ++count === this.fields.length) {
              callback(valid);
            }
          });
        });

        if (errorField) {
          const errorEl = errorField.$el;
          const scrollableAncestor = getScrollableAncestor(this.$el);
          const errorElClientSize = errorEl.getBoundingClientRect();
          const userOffset = this.scrollOffset;
          const scrollOffset = errorElClientSize.top;
          const currentScrollOffset = scrollableAncestor.scrollTop || scrollableAncestor.scrollY || 0;
          const scrollTo = currentScrollOffset + scrollOffset + userOffset;

          checkIsShouldScroll(errorElClientSize, userOffset, scrollTo, this.groupName, () => {
            if (typeof scrollableAncestor.scrollTo === 'function') {
              scrollableAncestor.scrollTo({ top: scrollTo, behavior: 'smooth' });
            } else {
              animationScroll(scrollableAncestor, scrollTo, 150, 5);
            }
          });
        }

        cleanupGroupFormsValidateInfo(this.groupName, this.formId);

        if (promise) {
          return promise;
        }
      },
      validateField(prop, cb) {
        let field = this.fields.filter(field => field.prop === prop)[0];
        if (!field) { throw new Error('must call validateField with valid prop string!'); }

        field.validate('', cb);
      }
    }
  };
</script>
