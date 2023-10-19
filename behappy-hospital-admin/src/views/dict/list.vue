<template>
  <div class="app-container">
    <el-form :inline="true" class="demo-form-inline">
      <el-form-item>
        <el-button type="text" @click="exportData"><i class="fa fa-plus"/> 导出</el-button>
        <el-button type="text" @click="dialogImportVisible = true"><i class="fa fa-plus"/> 导入</el-button>
      </el-form-item>
    </el-form>
    <el-table
      :data="list"
      :load="getChildren"
      :tree-props="{children: 'children', hasChildren: 'hasChildren'}"
      style="width: 100%"
      row-key="id"
      border
      lazy>
      <el-table-column label="名称" width="230" align="left">
        <template slot-scope="scope">
          <span>{{ scope.row.name }}</span>
        </template>
      </el-table-column>
      <el-table-column label="编码" width="220">
        <template slot-scope="{row}">
          {{ row.dictCode }}
        </template>
      </el-table-column>
      <el-table-column label="值" width="230" align="left">
        <template slot-scope="scope">
          <span>{{ scope.row.value }}</span>
        </template>
      </el-table-column>
      <el-table-column label="创建时间" align="center">
        <template slot-scope="scope">
          <span>{{ scope.row.createTime }}</span>
        </template>
      </el-table-column>
    </el-table>
    <el-dialog :visible.sync="dialogImportVisible" title="导入" width="480px">
      <el-form label-position="right" label-width="170px">
        <el-form-item label="文件">
          <el-upload
            :multiple="false"
            :on-success="onUploadSuccess"
            :action="`${baseUrl}/admin/cmn/dict/importData`"
            class="upload-demo">
            <el-button size="small" type="primary">点击上传</el-button>
            <div slot="tip" class="el-upload__tip">只能上传xlsx文件，且不超过500kb</div>
          </el-upload>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogImportVisible = false">
          取消
        </el-button>
      </div>
    </el-dialog>

  </div>
</template>
<script>
import dictApi from '../../api/dict/dictApi'

export default {
  name: 'Dict',
  data() {
    return {
      // 数据字典列表数组
      list: [],
      dialogImportVisible: false,
      baseUrl: process.env.BASE_API
    }
  },
  created() {
    // 初始化1
    this.getDictList()
  },
  methods: {
    // 数据字典列表
    getDictList(id = 1) {
      dictApi.dictList(id)
        .then(response => {
          this.list = response.data
        })
    },
    getChildren(tree, treeNode, resolve) {
      dictApi.dictList(tree.id).then(response => {
        resolve(response.data)
      })
    },
    exportData() {
      window.location.href = `${process.env.BASE_API}/admin/cmn/dict/exportData`
    },
    onUploadSuccess(response, file) {
      this.$message.success('上传成功')
      this.dialogImportVisible = false
      this.getDictList()
    }
  }
}
</script>

<style scoped>

</style>
