<style>
  .demo-transfer {
    .transfer-footer {
      margin-left: 15px;
      padding: 6px 5px;
    }
  }
</style>

<script>
  export default {
    data() {
      const generateData = _ => {
        const data = [];
        for (let i = 1; i <= 115; i++) {
          data.push({
            key: i,
            label: `备选项 ${ i }`,
            disabled: i % 4 === 0
          });
        }
        return data;
      };
      const generateData2 = _ => {
        const data = [];
        const cities = ['上海', '北京', '广州', '深圳', '南京', '西安', '成都'];
        const pinyin = ['shanghai', 'beijing', 'guangzhou', 'shenzhen', 'nanjing', 'xian', 'chengdu'];
        cities.forEach((city, index) => {
          data.push({
            label: city,
            key: index,
            pinyin: pinyin[index]
          });
        });
        return data;
      };
      const generateData3 = _ => {
        const data = [];
        for (let i = 1; i <= 15; i++) {
          data.push({
            value: i,
            desc: `备选项 ${ i }`,
            disabled: i % 4 === 0
          });
        }
        return data;
      };
      const generateData4 = _ => {
        const data = [];
        for (let i = 1; i <= 20; i++) {
          data.push({
            key: i,
            label: i === 1 ? `备选项备选项备选项备选项备选项备选项${ i }` : `备选项${i}`,
            disabled: false
          });
        }
        return data;
      };
      return {
        initRemoteTotal: 200,
        remoteTotal: [200],
        data: generateData(),
        data2: generateData2(),
        data3: generateData3(),
        dataRemote: generateData4(),
        value1: [1, 4],
        value2: [],
        value3: [1],
        value4: [],
        valueRemote: [],
        filterMethod(query, item) {
          return item.pinyin.indexOf(query) > -1;
        },
        renderFunc(h, option) {
          return <span>{ option.key } - { option.label }</span>;
        }
      };
    },

    computed: {
      leftHasMore () {
        return this.remoteTotal[0] > this.dataRemote.length
      }
    },

    methods: {
      handleChange(value, direction, movedKeys) {
        console.log(value, direction, movedKeys);
      },
      requestApi() {
        return new Promise((resolve, reject) => {
          setTimeout(() => {
            resolve();
          }, 1000);
        });
      },
      beforeQuery(title, query) {
        if(title === '列表 1') {
          return this.requestApi(`/api/cities?name=${query}&limit=10&offset=1`);
        }
      },
      loadMoreFormRemote () {
        // 模拟数据追加
        let arr = [];
        for (let i = 1; i <=20; i++) {
          let item = {
            key: this.dataRemote.length + i,
            label: 'xxx' + i,
            disabled: false
          }
          arr.push(item);
        }
        this.dataRemote = this.dataRemote.concat(arr);
      },
      handleChangeRemote (value, direc, movedKeys) {
        // 每次数据左右挪的时候，需要动态变化左侧的总量数字
        this.remoteTotal = [this.initRemoteTotal - value.length];
        // 当前总的取回来的数据个数在左侧剩的只有8个了，就自动加载下一页
        if (this.dataRemote.length - this.valueRemote.length < 8 && this.dataRemote.length < this.initRemoteTotal) {
          this.loadMoreFormRemote()
        }
      }
    }
  };
</script>

## Transfer 穿梭框

### 基础用法
:::demo Transfer 的数据通过 `data` 属性传入。数据需要是一个对象数组，每个对象有以下属性：`key` 为数据的唯一性标识，`label` 为显示文本，`disabled` 表示该项数据是否禁止转移。目标列表中的数据项会同步到绑定至 `v-model` 的变量，值为数据项的 `key` 所组成的数组。当然，如果希望在初始状态时目标列表不为空，可以像本例一样为 `v-model` 绑定的变量赋予一个初始值。
```html
<template>
  <el-transfer v-model="value1" :data="data">
  </el-transfer>
</template>

<script>
  export default {
    data() {
      const generateData = _ => {
        const data = [];
        for (let i = 1; i <= 15; i++) {
          data.push({
            key: i,
            label: `备选项 ${ i }`,
            disabled: i % 4 === 0
          });
        }
        return data;
      };
      return {
        data: generateData(),
        value1: [1, 4]
      };
    }
  };
</script>
```
:::

### 加载更多，远端分页
:::demo Transfer 的数据通过 `data` 属性传入。接口分页数据是ajax 回来，全量的那个分页不适合，这时候可以用 `left-remote-load-more` 作为 slot 传入，自主外部控制分页逻辑, `show-overflow-tip` 当内容过多被隐藏时展示tooltip。
```html
<template>
  <el-transfer v-model="valueRemote" :data="dataRemote" :total-elements="remoteTotal" :show-overflow-tip="true" @change="handleChangeRemote">
    <div v-show="leftHasMore" @click="loadMoreFormRemote" class="load-more" slot="left-remote-load-more">加载更多</div>
  </el-transfer>
</template>

<script>
  export default {
    data() {
      const generateData = _ => {
        const data = [];
        for (let i = 1; i <= 20; i++) {
          data.push({
            key: i,
            label: `备选项 ${ i }`,
            disabled: false
          });
        }
        return data;
      };
      return {
        initRemoteTotal: 200,
        remoteTotal: [200],
        dataRemote: generateData(),
        valueRemote: []
      };
    },
    methods: {
      loadMoreFormRemote () {
        // 模拟数据追加
        let arr = [];
        for (let i = 1; i <=20; i++) {
          let item = {
            key: this.dataRemote.length + i,
            label: 'xxx' + i,
            disabled: false
          }
          arr.push(item);
        }
        this.dataRemote = this.dataRemote.concat(arr);
      },
      handleChangeRemote (value, direc, movedKeys) {
        // 每次数据左右挪的时候，需要动态变化左侧的总量数字
        this.remoteTotal = [this.initRemoteTotal - value.length];
        // 当前总的取回来的数据个数在左侧剩的只有8个了，就自动加载下一页
        if (this.dataRemote.length - this.valueRemote.length < 8 && this.dataRemote.length < this.initRemoteTotal) {
          this.loadMoreFormRemote()
        }
      }
    }
  };
</script>
```
:::


### 可搜索

在数据很多的情况下，可以对数据进行搜索和过滤。

:::demo 设置 `filterable` 为 `true` 即可开启搜索模式。默认情况下，若数据项的 `label` 属性包含搜索关键字，则会在搜索结果中显示。你也可以使用 `filter-method` 定义自己的搜索逻辑。`filter-method` 接收一个方法，当搜索关键字变化时，会将当前的关键字和每个数据项传给该方法。若方法返回 `true`，则会在搜索结果中显示对应的数据项。
```html
<template>
  <el-transfer
    filterable
    :filter-method="filterMethod"
    filter-placeholder="请输入城市拼音"
    v-model="value2"
    :data="data2" :total-elements="[1400, 1500]">
  </el-transfer>
</template>

<script>
  export default {
    data() {
      const generateData2 = _ => {
        const data = [];
        const cities = ['上海', '北京', '广州', '深圳', '南京', '西安', '成都'];
        const pinyin = ['shanghai', 'beijing', 'guangzhou', 'shenzhen', 'nanjing', 'xian', 'chengdu'];
        cities.forEach((city, index) => {
          data.push({
            label: city,
            key: index,
            pinyin: pinyin[index]
          });
        });
        return data;
      };
      return {
        data2: generateData2(),
        value2: [],
        filterMethod(query, item) {
          return item.pinyin.indexOf(query) > -1;
        }
      };
    }
  };
</script>
```
:::

### 异步数据搜索

在数据为服务端异步请求的时候，可以等待数据加载完毕再对数据进行搜索和过滤。

:::demo 设置 `filterable` 为 `true` 即可开启搜索模式。默认情况下，若数据项的 `label` 属性包含搜索关键字，则会在搜索结果中显示。你也可以使用 `filter-method` 定义自己的搜索逻辑。`filter-method` 接收一个方法，当搜索关键字变化时，会将当前的关键字和每个数据项传给该方法。若方法返回 `true`，则会在搜索结果中显示对应的数据项。在`before-query`函数中，执行异步方法，且返回promise，就可以进行异步数据搜索。`before-query`对外返回`title`和`query`。
```html
<template>
  <el-transfer
    :query-str-trim="true"
    filterable
    :filter-method="filterMethod"
    filter-placeholder="请输入城市拼音"
    v-model="value2"
    :before-query="beforeQuery"
    :data="data2">
  </el-transfer>
</template>

<script>
  export default {
    data() {
      const generateData2 = _ => {
        const data = [];
        const cities = ['上海', '北京', '广州', '深圳', '南京', '西安', '成都'];
        const pinyin = ['shanghai', 'beijing', 'guangzhou', 'shenzhen', 'nanjing', 'xian', 'chengdu'];
        cities.forEach((city, index) => {
          data.push({
            label: city,
            key: index,
            pinyin: pinyin[index]
          });
        });
        return data;
      };
      return {
        data2: generateData2(),
        value2: [],
        filterMethod(query, item) {
          return item.pinyin.indexOf(query) > -1;
        }
      };
    },
    methods: {
      requestApi(url) {
        return new Promise((resolve, reject) => {
          setTimeout(() => {
            resolve();
          }, 1000);
        });
      },
      beforeQuery(title, query) {
        if(title === '列表 1') {
          return this.requestApi(`/api/cities?name=${query}&limit=10&offset=1`);
        }
      }
    }
  };
</script>
```
:::

### 可自定义

可以对列表标题文案、按钮文案、数据项的渲染函数、列表底部的勾选状态文案、列表底部的内容区等进行自定义。

:::demo 可以使用 `titles`、`button-texts`、`render-content` 和 `format` 属性分别对列表标题文案、按钮文案、数据项的渲染函数和列表顶部的勾选状态文案进行自定义。对于列表底部的内容区，提供了两个具名 slot：`left-footer` 和 `right-footer`。此外，如果希望某些数据项在初始化时就被勾选，可以使用 `left-default-checked` 和 `right-default-checked` 属性。最后，本例还展示了 `change` 事件的用法。注意：由于 jsfiddle 不支持 JSX 语法，所以本例在 jsfiddle 中无法运行。但是在实际的项目中，只要正确地配置了相关依赖，就可以正常运行。
```html
<template>
  <el-transfer
    v-model="value3"
    filterable
    :left-default-checked="[2, 3]"
    :right-default-checked="[1]"
    :render-content="renderFunc"
    :titles="['Source', 'Target']"
    :button-texts="['到左边', '到右边']"
    :page-sizes="[10,10]"
    load-more-text="加载更多"
    target-order="unshift"
    :formats="[{
      noChecked: '总数：${total}',
      hasChecked: '${checked}/${total}'
    }, {
      noChecked: '${total}',
      hasChecked: '${checked}/${total}'
    }]"
    @change="handleChange"
    :data="data">
    <el-button class="transfer-footer" slot="left-footer" size="small">操作</el-button>
    <el-button class="transfer-footer" slot="right-footer" size="small">操作</el-button>
  </el-transfer>
</template>

<style>
  .transfer-footer {
    margin-left: 20px;
    padding: 6px 5px;
  }
</style>

<script>
  export default {
    data() {
      const generateData = _ => {
        const data = [];
        for (let i = 1; i <= 115; i++) {
          data.push({
            key: i,
            label: `备选项 ${ i }`,
            disabled: i % 4 === 0
          });
        }
        return data;
      };
      return {
        data: generateData(),
        value3: [1],
        renderFunc(h, option) {
          return <span>{ option.key } - { option.label }</span>;
        }
      };
    },

    methods: {
      handleChange(value, direction, movedKeys) {
        console.log(value, direction, movedKeys);
      }
    }
  };
</script>
```
:::

### 数据项属性别名

默认情况下，Transfer 仅能识别数据项中的 `key`、`label` 和 `disabled` 字段。如果你的数据的字段名不同，可以使用 `props` 属性为它们设置别名。
:::demo 本例中的数据源没有 `key` 和 `label` 字段，在功能上与它们相同的字段名为 `value` 和 `desc`。因此可以使用`props` 属性为 `key` 和 `label` 设置别名。
```html
<template>
  <el-transfer
    v-model="value4"
    :props="{
      key: 'value',
      label: 'desc'
    }"
    :data="data3">
  </el-transfer>
</template>

<script>
  export default {
    data() {
      const generateData3 = _ => {
        const data = [];
        for (let i = 1; i <= 15; i++) {
          data.push({
            value: i,
            desc: `备选项 ${ i }`,
            disabled: i % 4 === 0
          });
        }
        return data;
      };
      return {
        data3: generateData3(),
        value4: []
      };
    }
  };
</script>
```
:::

### Attributes
| 参数      | 说明    | 类型      | 可选值       | 默认值   |
|---------- |-------- |---------- |-------------  |-------- |
| data | Transfer 的数据源 | array[{ key, label, disabled }] | — | [ ] |
| filterable | 是否可搜索 | boolean | — | false |
| filter-placeholder | 搜索框占位符 | string | — | 请输入搜索内容 |
| filter-method | 自定义搜索方法 | function | — | — |
| target-order | 右侧列表元素的排序策略：若为 `original`，则保持与数据源相同的顺序；若为 `push`，则新加入的元素排在最后；若为 `unshift`，则新加入的元素排在最前 | string | original / push / unshift | original |
| titles | 自定义列表标题 | array | — | ['列表 1', '列表 2'] |
| button-texts | 自定义按钮文案 | array | — | [ ] |
| render-content | 自定义数据项渲染函数 | function(h, option) | — | — |
| format | 列表顶部勾选状态文案 | object{noChecked, hasChecked} | — | { noChecked: '${checked}/${total}', hasChecked: '${checked}/${total}' } |
| formats | 列表顶部勾选状态文案/分左右两版 | array{noChecked, hasChecked} | — | [{ noChecked: '${checked}/${total}', hasChecked: '${checked}/${total}' }, { noChecked: '${checked}/${total}', hasChecked: '${checked}/${total}' }] |
| props | 数据源的字段别名 | object{key, label, disabled} | — | — |
| left-default-checked | 初始状态下左侧列表的已勾选项的 key 数组 | array | — | [ ] |
| right-default-checked | 初始状态下右侧列表的已勾选项的 key 数组 | array | — | [ ] |
| before-query | 搜索框异步搜索前，触发的函数 | function(title, query) | — | [ ] |
| page-sizes | 穿梭框分页条数 | array[number, number] | — | [ ] |
| total-elements | 自定义穿梭框总条数 | array[number, number] | — | [ ] |
| show-overflow-tip | 内容超出限制宽度是否展示tooltip | Boolean | - | false |
| query-str-trim | 搜索框里的搜索词是否去收尾空格，默认不去除 | Boolean | - | false |
### Slot
| name | 说明 |
|------|--------|
| left-footer | 左侧列表底部的内容 |
| right-footer | 右侧列表底部的内容 |
| left-remote-load-more | 左侧列表异步分页的按钮位置 |
| right-remote-load-more | 右侧列表异步分页的按钮位置 |

### Methods
| 方法名 | 说明 | 参数 |
| ---- | ---- | ---- |
| clearQuery | 清空某个面板的搜索关键词 | 'left' / 'right'，指定需要清空的面板 |

### Events
| 事件名称      | 说明    | 回调参数      |
|---------- |-------- |---------- |
| change | 右侧列表元素变化时触发 | 当前值、数据移动的方向（'left' / 'right'）、发生移动的数据 key 数组 |
| left-check-change | 左侧列表元素被用户选中 / 取消选中时触发 | 当前被选中的元素的 key 数组、选中状态发生变化的元素的 key 数组 |
| right-check-change | 右侧列表元素被用户选中 / 取消选中时触发 | 当前被选中的元素的 key 数组、选中状态发生变化的元素的 key 数组 |
