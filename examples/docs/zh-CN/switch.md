<style>
  .demo-box.demo-switch {
    .el-switch {
      margin: 20px 20px 20px 0;
    }
  }
</style>

<script>
  export default {
    data() {
      return {
        value1: true,
        value2: true,
        value3: true,
        value4: true,
        value5: '100',
        value6: true,
        value7: false
      }
    }
  };
</script>

## Switch 开关

:::tip 
新规范调整内容
* ##### 新规范中规定设计稿中默认只能有两种尺寸的按钮（默认和small），默认宽度54px、高度22px，small对应宽度47px、高度18px。
注意修改事项：
* ##### 小尺寸添加了 size="small"。
* ##### 默认文案只支持ON和OFF
* ##### 按照公司产品的逻辑统一：active-text="OFF" inactive-text="ON"
* ##### 增加 switch 左右两侧 label
:::

表示两种相互对立的状态间的切换，多用于触发「开/关」。

### 基本用法

:::demo 绑定`v-model`到一个`Boolean`类型的变量。可以使用`active-color`属性与`inactive-color`属性来设置开关的背景色。

```html
<el-switch
  v-model="value2"
  active-text="OFF"
  inactive-text="ON">
</el-switch>

<el-switch
  size="small"
  v-model="value2">
</el-switch>
<script>
  export default {
    data() {
      return {
        value1: true,
        value2: true
      }
    }
  };
</script>
```
:::

### 带 label 用法
:::demo 组件提供两种方式添加左右 label 或其它内容。 1、slot 插槽形式，增加左右两个插槽 `left-content` 和 `right-content`  2、props 传入值形式，同样增加两个 `left-label` 和 `right-label`

```html
<el-switch
  v-model="value3"
  active-text="关"
  left-label="LABEL"
  inactive-text="开">
  <span slot="right-content">LABEL</span>
</el-switch>
<el-switch
  v-model="value3"
  active-text="关"
  right-label="xxx"
  inactive-text="开">
  <span slot="right-content">LABEL</span>
</el-switch><br/>
<el-switch
  size="small"
  v-model="value3"
  right-label="xxx">
  <span slot="right-content">LABEL</span>
</el-switch><br/>
<el-switch
  disabled
  v-model="value3"
  right-label="xxx">
  <span slot="right-content">LABEL</span>
</el-switch>
```
:::
### 文字描述

:::demo 使用`active-text`属性与`inactive-text`属性来设置开关的文字描述。

```html
<el-switch
  v-model="value3"
  active-text="关"
  inactive-text="开">
</el-switch>
<el-switch
  v-model="value4"
  active-color="#13ce66"
  inactive-color="#ff4949"
  active-text="OFF"
  inactive-text="ON">
</el-switch>
<el-switch
  size="small"
  v-model="value3">
</el-switch>
<el-switch
  size="small"
  v-model="value4"
  active-color="#13ce66"
  inactive-color="#ff4949">
</el-switch>

<script>
  export default {
    data() {
      return {
        value3: true,
        value4: true
      }
    }
  };
</script>
```
:::

### 扩展的 value 类型

:::demo 设置`active-value`和`inactive-value`属性，接受`Boolean`, `String`或`Number`类型的值。

```html
<el-tooltip :content="'Switch value: ' + value5" placement="top">
  <el-switch
    v-model="value5"
    active-color="#13ce66"
    inactive-color="#ff4949"
    active-value="100"
    inactive-value="0">
  </el-switch>
</el-tooltip>

<script>
  export default {
    data() {
      return {
        value5: '100'
      }
    }
  };
</script>
```

:::

### 禁用状态

:::demo 设置`disabled`属性，接受一个`Boolean`，设置`true`即可禁用。


```html
<el-switch
  v-model="value6"
  disabled>
</el-switch>
<el-switch
  v-model="value7"
  disabled>
</el-switch>
<script>
  export default {
    data() {
      return {
        value6: true,
        value7: false
      }
    }
  };
</script>
```
:::


### Attributes

| 参数      | 说明    | 类型      | 可选值       | 默认值   |
|---------- |-------- |---------- |-------------  |-------- |
| size  | 尺寸    | string   | -/small | -   |
| disabled  | 是否禁用    | boolean   | — | false   |
| width  | switch 的宽度（像素）    | number   | — | 40 |
| active-icon-class  | switch 打开时所显示图标的类名，设置此项会忽略 `active-text`    | string   | — | — |
| inactive-icon-class  | switch 关闭时所显示图标的类名，设置此项会忽略 `inactive-text`    | string   | — | — |
| active-text  | switch 打开时的文字描述    | string   | — | — |
| inactive-text  | switch 关闭时的文字描述    | string   | — | — |
| active-value  | switch 打开时的值    | boolean / string / number | — | true |
| inactive-value  | switch 关闭时的值    | boolean / string / number | — | false |
| active-color  | switch 打开时的背景色    | string   | — | #409EFF |
| inactive-color  | switch 关闭时的背景色    | string   | — | #C0CCDA |
| name  | switch 对应的 name 属性    | string   | — | — |

### Events
| 事件名称      | 说明    | 回调参数      |
|---------- |-------- |---------- |
| change  | switch 状态发生变化时的回调函数    | 新状态的值 |

### Methods
| 方法名 | 说明 | 参数 |
| ---- | ---- | ---- |
| focus | 使 Switch 获取焦点 | - |