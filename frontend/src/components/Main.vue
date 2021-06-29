<template>
  <div class="wrapper">
    <div class="header">
      <div class="title-wrapper">
        <div class="title title-head">모델명</div>
        <select style="vertical-align: middle; text-align-last: center;" class="title title-body" @change="onchangeModel($event)">
          <option v-for="(model , index) in modelList" :key="index">
            {{ model.name }}
          </option>
        </select>
      </div>
      <div class="title-wrapper">
        <div class="title title-head">설비 <br>제조사</div>
        <div class="title title-body">{{ companyName }}</div>
      </div>
      <div class="title-wrapper">
        <div class="title title-head">설비 모델</div>
        <div class="title title-body">{{ equipmentModel }}</div>
      </div>
      <div class="title-wrapper">
        <div class="title title-head">첨부 도면</div>
        <b-dropdown class="title title-body" style="background-color: #6c757d;" text="---">
          <b-dropdown-item v-for="(drawing, index) in drawingList" :key="index">
            <router-link :to="{ name: 'drawing', params: { url: drawing.image_url } }" class="link">{{ drawing.image_url }}</router-link>
          </b-dropdown-item>
        </b-dropdown>
      </div>
    </div>
    <div class="body">
      <div class="dropdown-wrapper" style="flex: 1">
        <div class="dropdown-custom-item">
          <div class="dropdown-title">원소재</div>
          <div class="dropdown-button" @click="elementOpened=!elementOpened">
            <b-icon-chevron-down ></b-icon-chevron-down>
          </div>        
        </div>
        <div class="content-wrapper">
          <div class="content">
            <div class="dropdown-content-wrapper" v-if="elementOpened">
              <div class="dropdown-content" v-for="item in elementList" :key="item.name" >
                  <div class="dropdown-content-item" v-bind:class="{ dropdownselected: selected['원소재'] === item.name }" @click="setSelected('원소재', item.name)">{{ item.name }}</div>
              </div>
              <div class="dropdown-content" v-for="index in 4-elementList.length > 0 ? 4-elementList.length : 0" :key="index"> 
                <div class="dropdown-content-item-empty ">{{ '-' }}</div>
               </div>
            </div>
          </div>
        </div>
      </div>
      <div class="dropdown-wrapper" style="flex: 5">
        <div class="dropdown-custom-item">
          <div class="dropdown-title">공구</div>
          <div class="dropdown-button" @click="toolOpened=!toolOpened">
            <b-icon-chevron-down ></b-icon-chevron-down>
          </div>
        </div>
        <div class="content-wrapper">
          <div class="content">
            <div class="dropdown-content-wrapper" v-if="toolOpened">
              <div class="dropdown-tool" v-for="(item, index) in toolList" :key="index">
                  <div class="dropdown-content-head">{{ item[0] ? item[0].type : index }}</div>

                  <div class="dropdown-content-item-child" v-bind:class="{ dropdownselected: selected[child.type] === child.name }" v-for="child in item" :key="child.name" @click="setSelected(child.type, child.name)">
                    {{ child.name }}
                  </div>
                  <div class="dropdwon-empty-child" :key="index" v-for="index in (4 - item.length > 0 ? 4 - item.length : 0)">
                    {{ '-' }}
                  </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="dropdown-wrapper" style="flex: 5">
        <div class="dropdown-custom-item">
          <div class="dropdown-title">설비명</div>
          <div class="dropdown-button" @click="processingOpened=!processingOpened">
            <b-icon-chevron-down ></b-icon-chevron-down>
          </div>
        </div>
        <div class="content-wrapper">
          <div class="content">
            <div class="dropdown-content-wrapper" v-if="processingOpened">
              <div class="dropdown-tool" v-for="(item, index) in processingList" :key="index">
                  <div class="dropdown-content-head">{{ item[0] ? item[0].type : index }}</div>

                  <div class="dropdown-content-item-child" v-bind:class="{ dropdownselected: selected[child.type] === child.name }" v-for="child in item" :key="child.name" @click="setSelected(child.type, child.name)">
                    {{ child.name }}
                  </div>

                  <div class="dropdwon-empty-child" :key="index" v-for="index in (4 - item.length > 0 ? 4 - item.length : 0)">
                    {{ '-' }}
                  </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!-- bottom -->
    <div class="footer">
      <div class="footer-content">
        <div class="footer-content-title">Spindle</div>
        <div class="footer-content-result" v-for="(result, index) in resultList" :key="index">
          {{ result.spindle }}
        </div>
      </div>
      <div class="footer-content">
        <div class="footer-content-title">FeedRate</div>
        <div class="footer-content-result" v-for="(result, index) in resultList" :key="index">
          {{ result.feedrate }}
        </div>
      </div>
    </div>
  </div>
</template>

<script>

export default {
  name: 'Main',
  data() {
    return {
    elementOpened: false,
    toolOpened: false,
    processingOpened: false,
    
    modelList: ['F/S', 'CON-ROD'],
    
    modelName: null,
    companyName: null,
    equipmentModel: null,
    drawingList: null,

    selected: {
      '원소재': null,
      
      '종류': null,
      '소재': null,
      '날수': null,
      '공구경': null,

      'X': null,
      'Y': null,
      'Z': null,
      'R': null,
    },

    resultList: [{ spindle: '데이터없음', feedrate: '데이터없음'}],
    elementList: [{ name: 'test1'},{ name: 'test2' },{ name: 'test3' }],
    toolList: {
      gonggugyung: [
        { type: 'gg', name: '01', value: 1 },
        { type: 'gg', name: '02', value: 2 },
        { type: 'gg', name: '03', value: 3 }
        ],
      kind: [
        { type: 'k', name: 'ct', value: 3 },
        { type: 'k', name: 'it', value: 2 },
        { type: 'k', name: 'nt', value: 1 }
        ],
      nalsoo: [
        { type: 'n', name: '1', value: 1 },
        { type: 'n', name: '2', value: 2 },
        { type: 'n', name: '3', value: 3 }
      ],
      sojae: [
        { type: 's', name: 'c', value: 2 },
        { type: 's', name: 'h', value: 1 },
        { type: 's', name: 't', value: 1 }
      ]
    },
    processingList: {
      gonggugyung: [
        { type: 'gg', name: '01' },
        { type: 'gg', name: '02' },
        { type: 'gg', name: '03' }
      ],
      kind: [
        { type: 'k', name: 'ct' },
        { type: 'k', name: 'it' },
        { type: 'k', name: 'nt' }
      ],
     nalsoo: [
        { type: 'n', name: '1' },
        { type: 'n', name: '2' },
        { type: 'n', name: '3' }
      ],
      sojae: [
        { type: 's', name: 'c' },
        { type: 's', name: 'h' },
        { type: 's', name: 't' }
      ]
    },
    }
  },
  methods: {
    async onchangeModel(event) {
      this.modelName = event.target.value
      this.setCurrentModel()

      const result = (await this.$axios.get(`api/model_info?modelName=${this.modelName}`)).data
      this.elementList = result.elementList
      this.toolList = result.toolList
      this.processingList =result.processingList
      for(const item in this.selected) {
        this.selected[item] = null
      }
      this.resultList = [{ spindle: '데이터없음', feedrate: '데이터없음'}]
    },
    setCurrentModel() {
      for(const item of this.modelList) {
        if(item.name === this.modelName) {
          this.companyName = item.equipment_company
          this.equipmentModel = item.equipment_model
        }
      }
    },
    async setSelected(type, value) {
      this.selected[type] = value
      const values = this.selected

      const resultList = (await this.$axios.get(`api/calculate?element=${values['원소재']}&tool1=${values['종류']}&tool2=${values['소재']}&tool3=${values['날수']}&tool4=${values['공구경']}&processing1=${values['X']}&processing2=${values['Y']}&processing3=${values['Z']}&processing4=${values['R']}`)).data
      if(resultList) {
        this.resultList = resultList
      } else {
        this.resultList = [{ spindle: '데이터없음', feedrate: '데이터없음'}]
      }
    },
    async getModelList() {
      const result = (await this.$axios.get('api/model_list')).data
      this.modelList = result.modelList
    }
  },
  async mounted() {
    await this.getModelList()
    this.modelName = this.modelList[0].name
    this.setCurrentModel()

    const result = (await this.$axios.get(`api/model_info?modelName=${this.modelName}`)).data
    this.elementList = result.elementList
    this.toolList = result.toolList
    this.processingList =result.processingList
    this.drawingList = result.drawingList
  },
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.wrapper {
  display: flex;
  flex-direction: column;
  padding: 16px;
  min-width: 1350px;
  max-width: 1920px;
  min-height: 1080px;
  background-color: #f7f7f7;
}
.header {
  display: flex;
}
.body {
  display: flex;
  min-height: 500px;
}
.title-wrapper {
  display: flex;
  flex: 1;
}
.title {
  display: flex;
  margin: 4px;
  color: #000;
  justify-content: center;
  font-weight: 700;
  line-height: 120%;
  background-color: #fff;
  box-shadow: 0px 2px 10px rgba(0, 30, 130, 0.1);
}
.title-head {
  align-items: center;
  flex: 1;
  font-size: 20px;
  padding: 8px;
  background-color: #ccc;
}
.title-body {
  align-items: center;
  flex: 2;
  font-size: 20px;
  border: 1px solid #ccc;
}

.dropdown-wrapper {
  display: flex;
  flex-direction: column;
  margin: 16px 16px 0px 0px;
}

.content-wrapper {
  display: flex;
}
.content {
  display: flex;
  flex-direction: column;
}
.dropdown-content {
  display: flex;
  margin: 4px 0px;
  
  max-width: 900px;
  height: 80px;
}
.dropdown-tool {
  display: -webkit-inline-box;
  margin: 4px 0px;
  width: 800px;
  height: 80px;
  flex-wrap: nowrap;
  
  overflow-x: auto;
  overflow: scroll;
  overflow-x: hidden;
  overflow-y: hidden;
}
.dropdown-custom-item {
  display: flex;
  align-items: center;
  border: 1px solid #ccc;
  width: 210px;
  font-size: 30px;
  box-shadow: 0px 2px 10px rgba(0, 30, 130, 0.1);
}
.dropdown-item-child {
  display: flex;
  align-items: center;
  border: 1px solid #ccc;
  width: 100px;
  font-size: 24px;
}
.dropdown-title {
  width: 100%;
  border-right: 1px solid #ccc;
}
.dropdown-button {
  background-color: #ccc;
  cursor: pointer;
}
.dropdown-content-wrapper {
  display: flex;
  flex-direction: column;
  margin-top: 8px;
  max-width: 805px;
  border: 1px solid #ccc;
}
.dropdown-content-head {
  margin: 4px;
  width: 200px !important;
  display: flex;
  justify-content: center;
  text-align: center;
  align-items: center;
  padding: 8px;
  border: 1px solid #ccc;
  font-size: 24px;
  background-color: #ccc;
}
.dropdown-content-item {
  margin: 4px;
  width: 200px !important;
  display: flex;
  justify-content: center;
  text-align: center;
  align-items: center;
  padding: 8px 2px;
  border: 1px solid #ccc;
  font-size: 24px;
  background-color: #ccc;
  box-shadow: 0px 2px 10px rgba(0, 30, 130, 0.1);
  cursor: pointer;
}
.dropdown-content-item-empty {
  margin: 4px;
  width: 200px !important;
  padding: 8px 2px;
  border: 1px solid #ccc;
  font-size: 24px;
  background-color: #fff;
}
.dropdown-content-item-child {
  margin: 4px;
  width: 140px !important;
  display: flex;
  justify-content: center;
  text-align: center;
  align-items: center;
  padding: 8px 2px;
  border: 1px solid #ccc;
  font-size: 24px;
  background-color: #ccc;
  box-shadow: 0px 2px 10px rgba(0, 30, 130, 0.1);
  cursor: pointer;
}
.dropdwon-empty-child {
  margin: 4px;
  width: 140px !important;
  padding: 8px 2px;
  border: 1px solid #ccc;
  font-size: 24px;
  background-color: #fff;  
}
.dropdown-content-item:hover {
  background-color: #f7f7f7;
}
.dropdownselected {
  background-color: rgb(248, 246, 118);
}
.dropdown-content-item-child:hover {
  background-color: #f7f7f7;
}
.footer {
  display: flex;
  margin-top: auto;
}
.footer-content {
  flex: 1;
  display: flex;
  margin-right: 2px;
  flex-direction: column;
  font-size: 24px;
  font-weight: bold;
  box-shadow: 0px 2px 10px rgba(0, 30, 130, 0.1);
}
.footer-content-title {
  padding: 16px;
  background-color: #ccc;
}
.footer-content-result {
  padding: 16px;
  background-color: #fff;
  border: 1px solid #ccc;

}
</style>
