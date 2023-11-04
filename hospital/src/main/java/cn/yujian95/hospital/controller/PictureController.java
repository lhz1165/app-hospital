package cn.yujian95.hospital.controller;

import cn.yujian95.hospital.common.api.CommonResult;
import cn.yujian95.hospital.component.QiniuComponent;
import cn.yujian95.hospital.util.FileUtils;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 * @author docker-compose
 * @date 2023/11/1
 */
@Api(value = "图片模块", tags = "图片接口")
@RestController
@CrossOrigin
@RequestMapping("/picture")
public class PictureController {

    @Value("${app.file.address}")
    public  String address;

    @Value("${app.file.domain}")
    public  String domain;

    @ApiOperation(value = "上传图片，返回图片url", notes = "传入 图片文件")
    @RequestMapping(value = "/upload", method = RequestMethod.POST)
    public CommonResult<String> uploadPicture(@RequestParam MultipartFile file) {
        try {
            if (file.isEmpty()) {
                return CommonResult.validateFailed("上传图片为空！");
            }
            byte[] bytes = file.getBytes();
            //要存入本地的地址放到path里面
            Path path = Paths.get( address + "/");
            //如果没有files文件夹，则创建
            if (!Files.isWritable(path)) {
                Files.createDirectories(path);
            }
            String extension = FileUtils.getFileExtension(file);  //获取文件后缀
            String filename = DateTimeFormatter.ofPattern("yyyyMMddHHmmss").format(LocalDateTime.now())+ extension;
            FileUtils.getFileByBytes(bytes, address, filename);

            String url = domain + "/img/" + filename;

            return CommonResult.success(url);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
