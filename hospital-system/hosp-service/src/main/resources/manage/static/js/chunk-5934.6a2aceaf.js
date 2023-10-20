(window.webpackJsonp=window.webpackJsonp||[]).push([["chunk-5934"],{"7zsw":function(t,e,n){"use strict";n.r(e);var o=n("ZU0Y"),a={name:"List",data:function(){return{list:null,current:1,limit:10,searchObj:{},total:0,multipleSelection:[]}},created:function(){this.getList()},methods:{getList:function(){var t=this,e=arguments.length>0&&void 0!==arguments[0]?arguments[0]:1;this.current=e,o.a.getPageList(this.current,this.limit,this.searchObj).then(function(e){t.list=e.data.records,t.total=e.data.total}).catch(function(t){console.error(t)})},removeDataById:function(t){var e=this;this.$confirm("此操作将永久删除医院设置信息, 是否继续?","提示",{confirmButtonText:"确定",cancelButtonText:"取消",type:"warning"}).then(function(){o.a.deleteHospSet(t).then(function(t){e.$message({type:"success",message:"删除成功!"}),e.getList()})})},removeRows:function(){var t=this;this.$confirm("此操作将永久删除医院设置信息, 是否继续?","提示",{confirmButtonText:"确定",cancelButtonText:"取消",type:"warning"}).then(function(){var e=t.multipleSelection.map(function(t){return t.id});o.a.removeRows(e).then(function(e){t.$message({type:"success",message:"删除成功!"}),t.getList()})})},handleSelectionChange:function(t){this.multipleSelection=t},lockHostSet:function(t,e){var n=this;o.a.lockHospSet(t,e).then(function(t){n.$message({type:"success",message:"更新状态成功!"}),n.getList()})}}},s=(n("X27M"),n("KHd+")),i=Object(s.a)(a,function(){var t=this,e=t.$createElement,n=t._self._c||e;return n("div",{staticClass:"app-container"},[n("el-form",{staticClass:"demo-form-inline",attrs:{inline:!0}},[n("el-form-item",[n("el-input",{attrs:{placeholder:"医院名称"},model:{value:t.searchObj.hosname,callback:function(e){t.$set(t.searchObj,"hosname",e)},expression:"searchObj.hosname"}})],1),t._v(" "),n("el-form-item",[n("el-input",{attrs:{placeholder:"医院编号"},model:{value:t.searchObj.hoscode,callback:function(e){t.$set(t.searchObj,"hoscode",e)},expression:"searchObj.hoscode"}})],1),t._v(" "),n("el-button",{attrs:{type:"primary",icon:"el-icon-search"},on:{click:function(e){t.getList()}}},[t._v("查询")])],1),t._v(" "),n("el-button",{attrs:{type:"danger",size:"mini"},on:{click:function(e){t.removeRows()}}},[t._v("批量删除")]),t._v(" "),n("el-table",{staticStyle:{width:"100%"},attrs:{data:t.list,stripe:""},on:{"selection-change":t.handleSelectionChange}},[n("el-table-column",{attrs:{type:"selection",width:"55"}}),t._v(" "),n("el-table-column",{attrs:{type:"index",width:"50"}}),t._v(" "),n("el-table-column",{attrs:{prop:"hosname",label:"医院名称"}}),t._v(" "),n("el-table-column",{attrs:{prop:"hoscode",label:"医院编号"}}),t._v(" "),n("el-table-column",{attrs:{prop:"apiUrl",label:"api基础路径",width:"200"}}),t._v(" "),n("el-table-column",{attrs:{prop:"contactsName",label:"联系人姓名"}}),t._v(" "),n("el-table-column",{attrs:{prop:"contactsPhone",label:"联系人手机"}}),t._v(" "),n("el-table-column",{attrs:{label:"状态",width:"80"},scopedSlots:t._u([{key:"default",fn:function(e){return[t._v("\n        "+t._s(1===e.row.status?"可用":"不可用")+"\n      ")]}}])}),t._v(" "),n("el-table-column",{attrs:{label:"操作",width:"280",align:"center"},scopedSlots:t._u([{key:"default",fn:function(e){return[n("el-button",{attrs:{type:"danger",size:"mini",icon:"el-icon-delete"},on:{click:function(n){t.removeDataById(e.row.id)}}}),t._v(" "),1==e.row.status?n("el-button",{attrs:{type:"primary",size:"mini",icon:"el-icon-delete"},on:{click:function(n){t.lockHostSet(e.row.id,0)}}},[t._v("锁定\n        ")]):0==e.row.status?n("el-button",{attrs:{type:"danger",size:"mini",icon:"el-icon-delete"},on:{click:function(n){t.lockHostSet(e.row.id,1)}}},[t._v("取消锁定\n        ")]):t._e(),t._v(" "),n("router-link",{attrs:{to:"/hospSet/edit/"+e.row.id}},[n("el-button",{attrs:{type:"primary",size:"mini",icon:"el-icon-edit"}})],1)]}}])})],1),t._v(" "),n("el-pagination",{staticStyle:{padding:"30px 0","text-align":"center"},attrs:{"current-page":t.current,"page-size":t.limit,total:t.total,layout:"total, prev, pager, next, jumper"},on:{"current-change":t.getList}})],1)},[],!1,null,"272c9637",null);i.options.__file="list.vue";e.default=i.exports},X27M:function(t,e,n){"use strict";var o=n("YKGJ");n.n(o).a},YKGJ:function(t,e,n){},ZU0Y:function(t,e,n){"use strict";var o=n("t3Un");e.a={getPageList:function(t,e,n){return Object(o.a)({url:"/admin/hosp/hospitalSet/findPageHospSet/"+t+"/"+e,method:"post",data:n})},deleteHospSet:function(t){return Object(o.a)({url:"/admin/hosp/hospitalSet/"+t,method:"delete"})},removeRows:function(t){return Object(o.a)({url:"/admin/hosp/hospitalSet/batchRemove",method:"delete",data:t})},lockHospSet:function(t,e){return Object(o.a)({url:"/admin/hosp/hospitalSet/lockHospitalSet/"+t+"/"+e,method:"put"})},saveHospSet:function(t){return Object(o.a)({url:"/admin/hosp/hospitalSet/saveHospitalSet",method:"post",data:t})},getHospSet:function(t){return Object(o.a)({url:"/admin/hosp/hospitalSet/getHospSet/"+t,method:"get"})},updateHospSet:function(t){return Object(o.a)({url:"/admin/hosp/hospitalSet/updateHospitalSet",method:"post",data:t})}}},t3Un:function(t,e,n){"use strict";var o=n("4d7F"),a=n.n(o),s=n("vDqi"),i=n.n(s),c=n("XJYT"),r=n("Q2AE"),l=n("X4fA"),u=i.a.create({baseURL:"https://easy-mock.com/mock/5950a2419adc231f356a6636/vue-admin",timeout:5e3});u.interceptors.request.use(function(t){return r.a.getters.token&&(t.headers.Authorization=Object(l.a)()),t},function(t){console.log(t),a.a.reject(t)}),u.interceptors.response.use(function(t){var e=t.data;return 200!==e.code?(Object(c.Message)({message:e.message,type:"error",duration:5e3}),50008!==e.code&&50012!==e.code&&50014!==e.code||c.MessageBox.confirm("你已被登出，可以取消继续留在该页面，或者重新登录","确定登出",{confirmButtonText:"重新登录",cancelButtonText:"取消",type:"warning"}).then(function(){r.a.dispatch("FedLogOut").then(function(){location.reload()})}),a.a.reject("error")):t.data},function(t){return console.log("err"+t),Object(c.Message)({message:t.message,type:"error",duration:5e3}),a.a.reject(t)}),e.a=u}}]);