<script>
  var iconList = require('examples/icon.json');
  let multIconList = require('../../../src/iconfont/iconfont.json')
  let singleIconList = require('../../../packages/theme-chalk/src/fonts/iconfont.json')
  let newSingleIconList = require('../../../packages/theme-chalk/src/fonts-new/iconfont.json')

  const customIcons = (function () {
    const icons = singleIconList.glyphs.map((item) => {
      return item.font_class
    })
    let customIcons = []
    const temp = []

    icons.map(it => it.replace(/_\d+$/, '')).forEach(item => {
      !temp.includes(item) && temp.push(item)
    })

    const list = temp.sort((a, b) => a.charAt().charCodeAt() - b.charAt().charCodeAt())
    list.forEach(item => {
      const items = icons.filter(it => it.replace(/_\d+$/, '') === item)
      customIcons = [...customIcons, ...items]
    })
    return customIcons
  })()

  const newIcons = (function () {
    return newSingleIconList.glyphs.map((item) => {
      return item.font_class
    })
  })()

  export default {
    data() {
      return {
        icons: iconList,
        multIcons: [...multIconList.glyphs],
        multIconListNav: [...multIconList.glyphs].filter((item) => {
          return item.name.indexOf('nav') > -1
        }),
        multIconListOther: [...multIconList.glyphs].filter((item) => {
          return item.name.indexOf('nav') === -1
        }),
        newIcons: newIcons,
        customIcons: customIcons,
        customIcons22: customIcons.filter((item) => {
          return item.indexOf('_22') > -1
        }),
        customIcons16: customIcons.filter((item) => {
          return item.indexOf('_16') > -1
        }),
        customIcons_old: customIcons.filter((item) => {
          return item.indexOf('_old') > -1
        }),
        customIconsTemp: customIcons.filter((item) => {
          return item.indexOf('_old') === -1 && item.indexOf('_22') === -1 && item.indexOf('_16') === -1
        })
      };
    },
    mounted () {
      console.log(this.multIconListNav)
    },
    methods: {
      handleCopy (val) {
        const tempInput = document.createElement('input')
        tempInput.value = val
        tempInput.style.opacity = 0
        document.body.appendChild(tempInput)
        tempInput.select()
        if (document.execCommand('copy')) {
          document.execCommand('copy')
          this.$message.success('复制成功')
        }
        document.body.removeChild(tempInput)
      }
    }
  }
</script>
<style>
  .demo-icon .source > i {
    color: #606266;
    margin: 0 20px;
    font-size: 1.5em;
    vertical-align: middle;
  }
  
  .demo-icon .source > button {
    margin: 0 20px;
  }

  .page-component .content > ul.icon-list {
    overflow: hidden;
    list-style: none;
    padding: 0;
    border: solid 1px #eaeefb;
    border-radius: 4px;
  }
  .icon-list li {
    float: left;
    width: 16.66%;
    text-align: center;
    height: 120px;
    line-height: 120px;
    color: #666;
    font-size: 13px;
    transition: color .15s linear;
    border-right: 1px solid #eee;
    border-bottom: 1px solid #eee;
    margin-right: -1px;
    margin-bottom: -1px;
    position: relative;

    @utils-vertical-center;

    span {
      display: inline-block;
      line-height: normal;
      vertical-align: middle;
      font-family: 'Helvetica Neue',Helvetica,'PingFang SC','Hiragino Sans GB','Microsoft YaHei',SimSun,sans-serif;
      color: #99a9bf;
    }
    
    i {
      display: block;
      font-size: 32px;
      margin-bottom: 15px;
      color: #606266;
    }
    
    .icon-name {
      display: inline-block;
      padding: 0 3px;
      height: 1em;
      color: #606266;
    }
    
    &:hover {
      color: rgb(92, 182, 255);
      .copy-layout {
        display: block
      }
    }
  }
  .copy-layout {
    display: none;
    width: 100%;
    padding: 10px 0;
    text-align: center;
    position: absolute;
    bottom: 0;
    left: 0;
    background-color: rgba(0, 0, 0, .7);
    color: #fff;
    cursor: pointer;
  }
  .mult-icon {
    list-style: none;

    li {
      display: inline-block;
      max-width: 120px;
      height: 150px;
      text-align: center;
      transition: color .15s linear;
      border-right: 1px solid #eee;
      border-bottom: 1px solid #eee;
      margin-right: 5px;
      margin-bottom: 5px;
      background: #054885;
      padding: 8px;
      box-sizing: border-box;
      @utils-vertical-center;
      position: relative;

      svg {
        font-size: 45px;
        margin-top: 10px;
      }

      span {
        display: inline-block;
        line-height: normal;
        font-family: 'Helvetica Neue',Helvetica,'PingFang SC','Hiragino Sans GB','Microsoft YaHei',SimSun,sans-serif;
        color: #fff;
        word-break: break-all;
        margin-top: 15px;
        vertical-align: top;
      }

      &:hover {
        .copy-layout {
          background-color: rgba(255, 255, 255, .9);
          color: #232323;
          display: block;
        }
      }
    }
  }
</style>
## Icon 图标

:::warning
根据目前新 icon 标准后期只维护一套 icon，故不再区分（6、16、22、24）尺寸。

新的 icon 已全部导入到组件库中，后期项目使用以及维护都按照 ```新 icon 标准``` 来，原先有尺寸的 icon，现阶段组件库里仍然保留（后期可能会隐藏，不做展示）。

由于为了和之前的共存以及区分，新的 icon 命名前缀做了更改，为一下形式 ```el-ksd-n-icon-<name>```
:::

:::tip 
提供了一套常用的图标集合。

此组件库维护了单色和多色两套 icon，其中由于组件里有 element-ui 自带的字体 icon，故为了区分组件自带的和自定义的做了以下区别处理：

- element-ui 自带的字体 icon 命名规则为 ```el-icon-<name>```，自定义的字体 icon 命名规则为 ```el-ksd-icon-<name>```
- 新标准的字体命名为 ```el-ksd-n-icon-<name>```
:::

### 使用方法

直接通过设置类名为 `el-icon-iconName` 来使用即可。例如：

:::demo
```html
<!-- <i class="el-icon-edit"></i>
<i class="el-icon-share"></i>
<i class="el-icon-delete"></i> -->
<el-button type="primary" icon="el-ksd-icon-search_22">搜索</el-button>

```
:::

### 图标集合

<h4>kyligence 新 icon 标准 ({{newIcons.length}})</h4>
<ul class="icon-list">
  <li v-for="item in newIcons" :key="item">
    <span>
      <i :class="'el-ksd-n-icon-' + item"></i>
      <span class="icon-name">{{`el-ksd-n-icon-${item}`}}</span>
      <div class="copy-layout" @click="handleCopy(`el-ksd-n-icon-${item}`)">复制</div>
    </span>
  </li>
</ul>

<h4>kyligence 特有 icon(22尺寸)</h4>
<ul class="icon-list">
  <li v-for="item in customIcons22" :key="item">
    <span>
      <i :class="'el-ksd-icon-' + item"></i>
      <span class="icon-name">{{`el-ksd-icon-${item}`}}</span>
      <div class="copy-layout" @click="handleCopy(`el-ksd-icon-${item}`)">复制</div>
    </span>
  </li>
</ul>

<h4>kyligence 特有 icon(16尺寸)</h4>
<ul class="icon-list">
  <li v-for="item in customIcons16" :key="item">
    <span>
      <i :class="'el-ksd-icon-' + item"></i>
      <span class="icon-name">{{`el-ksd-icon-${item}`}}</span>
      <div class="copy-layout" @click="handleCopy(`el-ksd-icon-${item}`)">复制</div>
    </span>
  </li>
</ul>

<h4>kyligence 特有 icon(临时版本 old)</h4>
<ul class="icon-list">
  <li v-for="item in customIcons_old" :key="item">
    <span>
      <i :class="'el-ksd-icon-' + item"></i>
      <span class="icon-name">{{`el-ksd-icon-${item}`}}</span>
      <div class="copy-layout" @click="handleCopy(`el-ksd-icon-${item}`)">复制</div>
    </span>
  </li>
</ul>

<h4>kyligence 特有 icon(非 22，16，old 的)</h4>
<ul class="icon-list">
  <li v-for="item in customIconsTemp" :key="item">
    <span>
      <i :class="'el-ksd-icon-' + item"></i>
      <span class="icon-name">{{`el-ksd-icon-${item}`}}</span>
      <div class="copy-layout" @click="handleCopy(`el-ksd-icon-${item}`)">复制</div>
    </span>
  </li>
</ul>

<h4 style="margin:20px 0">element ui 自带 icon（项目中引入时，尽量用特有的，不用这里的）</h4>
<ul class="icon-list">
  <li v-for="name in icons" :key="name">
    <span>
      <i :class="'el-icon-' + name"></i>
      <span class="icon-name">{{'el-icon-' + name}}</span>
      <div class="copy-layout" @click="handleCopy(`el-icon-${name}`)">复制</div>
    </span>
  </li>
</ul>

### 多色图标

:::demo
```html
<template>
  <h4>Nav bar 多色菜单</h4>
  <ul class="mult-icon">
    <template v-if="multIconListNav">
      <li v-for="item in multIconListNav" :key="item.icon_id">
        <el-icon :name="`el-ksd-icon-${item.font_class}`" type="mult"></el-icon>
        <span>{{'el-ksd-icon-' + item.font_class}}</span>
        <div class="copy-layout" @click="handleCopy(`el-ksd-icon-${item.font_class}`)">复制</div>
      </li>
    </template>
  </ul>
  <h4>其他多色 icon</h4>
  <ul class="mult-icon">
    <template v-if="multIconListOther">
      <li v-for="item in multIconListOther" :key="item.icon_id">
        <el-icon :name="`el-ksd-icon-${item.font_class}`" type="mult"></el-icon>
        <span>{{'el-ksd-icon-' + item.font_class}}</span>
        <div class="copy-layout" @click="handleCopy(`el-ksd-icon-${item.font_class}`)">复制</div>
      </li>
    </template>
  </ul>
</template>
```
