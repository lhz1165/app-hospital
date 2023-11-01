package cn.yujian95.hospital.controller;

import cn.yujian95.hospital.common.api.CommonResult;
import cn.yujian95.hospital.component.QiniuComponent;
import cn.yujian95.hospital.util.FileUtils;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

/**
 * @author YuJian95  clj9509@163.com
 * @date 2020/2/6
 */
@Api(value = "图片模块", tags = "图片接口")
@RestController
@CrossOrigin
@RequestMapping("/picture")
public class PictureController {

    @ApiOperation(value = "上传图片，返回图片url", notes = "传入 图片文件")
    @RequestMapping(value = "/upload", method = RequestMethod.POST)
    public CommonResult<String> uploadPicture(@RequestParam MultipartFile file) {
        try {
            if (file.isEmpty()) {
                return CommonResult.validateFailed("上传图片为空！");
            }
            byte[] bytes = file.getBytes();
            //要存入本地的地址放到path里面
            Path path = Paths.get( FileUtils.UPLOAD_FOLDER + "/");
            //如果没有files文件夹，则创建
            if (!Files.isWritable(path)) {
                Files.createDirectories(path);
            }
            String extension = FileUtils.getFileExtension(file);  //获取文件后缀
            FileUtils.getFileByBytes(bytes, FileUtils.UPLOAD_FOLDER, "上传文件" + extension);

//            if (!StringUtils.isEmpty(url)) {
//                return CommonResult.success(url);
//            }
            return CommonResult.failed("服务器错误，请联系管理员！");
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
