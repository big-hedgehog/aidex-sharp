package com.aidex.common.utils.file;

import java.io.*;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ch.qos.logback.core.util.FileUtil;
import org.apache.commons.lang3.ArrayUtils;
import com.aidex.common.utils.StringUtils;

/**
 * 文件处理工具类
 * 
 * @author ruoyi
 */
public class FileUtils extends org.apache.commons.io.FileUtils
{
    public static final String FILENAME_PATTERN = "[a-zA-Z0-9_\\-\\|\\.\\u4e00-\\u9fa5]+";

    /**
     * 输出指定文件的byte数组
     * 
     * @param filePath 文件路径
     * @param os 输出流
     * @return
     */
    public static void writeBytes(String filePath, OutputStream os) throws IOException
    {
        FileInputStream fis = null;
        try
        {
            File file = new File(filePath);
            if (!file.exists())
            {
                throw new FileNotFoundException(filePath);
            }
            fis = new FileInputStream(file);
            byte[] b = new byte[1024];
            int length;
            while ((length = fis.read(b)) > 0)
            {
                os.write(b, 0, length);
            }
        }
        catch (IOException e)
        {
            throw e;
        }
        finally
        {
            if (os != null)
            {
                try
                {
                    os.close();
                }
                catch (IOException e1)
                {
                    e1.printStackTrace();
                }
            }
            if (fis != null)
            {
                try
                {
                    fis.close();
                }
                catch (IOException e1)
                {
                    e1.printStackTrace();
                }
            }
        }
    }

    /**
     * 删除文件
     * 
     * @param filePath 文件
     * @return
     */
    public static boolean deleteFile(String filePath)
    {
        boolean flag = false;
        File file = new File(filePath);
        // 路径为文件且不为空则进行删除
        if (file.isFile() && file.exists())
        {
            file.delete();
            flag = true;
        }
        return flag;
    }

    /**
     * 文件名称验证
     * 
     * @param filename 文件名称
     * @return true 正常 false 非法
     */
    public static boolean isValidFilename(String filename)
    {
        return filename.matches(FILENAME_PATTERN);
    }

    /**
     * 检查文件是否可下载
     * 
     * @param resource 需要下载的文件
     * @return true 正常 false 非法
     */
    public static boolean checkAllowDownload(String resource)
    {
        // 禁止目录上跳级别
        if (StringUtils.contains(resource, ".."))
        {
            return false;
        }

        // 检查允许下载的文件规则
        if (ArrayUtils.contains(MimeTypeUtils.DEFAULT_ALLOWED_EXTENSION, FileTypeUtils.getFileType(resource)))
        {
            return true;
        }

        // 不在允许下载的文件规则
        return false;
    }

    /**
     * 下载文件名重新编码
     * 
     * @param request 请求对象
     * @param fileName 文件名
     * @return 编码后的文件名
     */
    public static String setFileDownloadHeader(HttpServletRequest request, String fileName) throws UnsupportedEncodingException
    {
        final String agent = request.getHeader("USER-AGENT");
        String filename = fileName;
        if (agent.contains("MSIE"))
        {
            // IE浏览器
            filename = URLEncoder.encode(filename, "utf-8");
            filename = filename.replace("+", " ");
        }
        else if (agent.contains("Firefox"))
        {
            // 火狐浏览器
            filename = new String(fileName.getBytes(), "ISO8859-1");
        }
        else if (agent.contains("Chrome"))
        {
            // google浏览器
            filename = URLEncoder.encode(filename, "utf-8");
        }
        else
        {
            // 其它浏览器
            filename = URLEncoder.encode(filename, "utf-8");
        }
        return filename;
    }

    /**
     * 下载文件名重新编码
     *
     * @param response 响应对象
     * @param realFileName 真实文件名
     * @return
     */
    public static void setAttachmentResponseHeader(HttpServletResponse response, String realFileName) throws UnsupportedEncodingException
    {
        String percentEncodedFileName = percentEncode(realFileName);

        StringBuilder contentDispositionValue = new StringBuilder();
        contentDispositionValue.append("attachment; filename=")
                .append(percentEncodedFileName)
                .append(";")
                .append("filename*=")
                .append("utf-8''")
                .append(percentEncodedFileName);

        response.setHeader("Content-disposition", contentDispositionValue.toString());
    }

    /**
     * 百分号编码工具方法
     *
     * @param s 需要百分号编码的字符串
     * @return 百分号编码后的字符串
     */
    public static String percentEncode(String s) throws UnsupportedEncodingException
    {
        String encode = URLEncoder.encode(s, StandardCharsets.UTF_8.toString());
        return encode.replaceAll("\\+", "%20");
    }



    /**
     * 获取指定（fileName）的扩展名称
     * @return
     */
    public static String getFileExtensionName(String filename){
        if ((filename != null) && (filename.length() > 0)) {
            int dot = filename.lastIndexOf('.');
            if ((dot > -1) && (dot < (filename.length() - 1))) {
                return filename.substring(dot + 1);
            }
        }
        return filename;
    }
    /**
     * 获取不带扩展名的文件名称
     * @param filename
     * @return
     */
    public static String getFileNameNoEx(String filename) {
        if ((filename != null) && (filename.length() > 0)) {
            int dot = filename.lastIndexOf('.');
            if ((dot >-1) && (dot < (filename.length()))) {
                return filename.substring(0, dot);
            }
        }
        return filename;
    }
    /**
     * 根据文件名称，获取文件icon
     * @param filename
     * @return
     */
    public static String getFileIcon(String filename){
        String icon = "";
        String exName = getFileExtensionName(filename);
        if("avi".equals(exName)){// avi
            icon = "avi.jpg";
        } else if("zip".equals(exName)){//zip
            return "zip.jpg";
        } else if("rar".equals(exName)){//rar
            return "rar.jpg";
        } else if("exe".equals(exName)){//exe
            return "exe.jpg";
        } else if("xls".equals(exName) || "xlsx".equals(exName)){//xls
            return "excel.jpg";
        } else if("doc".equals(exName) || "docx".equals(exName)){//doc
            return "word.jpg";
        } else if("ppt".equals(exName) || "pptx".equals(exName) ){//ppt
            return "ppt.jpg";
        } else if("txt".equals(exName)){//txt
            return "txt.jpg";
        } else if("chm".equals(exName)){//chm
            return "chm.jpg";
        } else if("pdf".equals(exName)){//pdf
            return "pdf.jpg";
        } else if("jpg".equals(exName)){//jpg
            return "jpg.jpg";
        } else if("png".equals(exName)){//png
            return "jpg.jpg";
        }else if("bmp".equals(exName)){//bmp
            return "bmp.jpg";
        } else if("gif".equals(exName)){//gif
            return "pic.jpg";
        } else if("html".equals(exName) || "htm".equals(exName) || "xhtml".equals(exName)){//html
            return "html.jpg";
        } else{
            return "normal.jpg";
        }
        return icon;
    }
    public static String getFileIconCss(String filename){
        String iconCss = "";
        String exName = getFileExtensionName(filename);
        if("zip".equals(exName)){//zip
            return "nui-ico-file nui-ico-file-rar";
        } else if("rar".equals(exName)){//rar
            return "nui-ico-file nui-ico-file-rar";
        }else if("xls".equals(exName) || "xlsx".equals(exName)){//xls
            return "nui-ico-file nui-ico-file-xls";
        } else if("doc".equals(exName) || "docx".equals(exName)){//doc
            return "nui-ico-file nui-ico-file-doc";
        } else if("ppt".equals(exName) || "pptx".equals(exName) ){//ppt
            return "nui-ico-file nui-ico-file-ppt";
        } else if("txt".equals(exName)){//txt
            return "nui-ico-file nui-ico-file-txt";
        } else if("chm".equals(exName)){//chm
            return "nui-ico-file nui-ico-file-html";
        } else if("html".equals(exName) || "htm".equals(exName) || "xhtml".equals(exName)){//html
            return "nui-ico-file nui-ico-file-html";
        } else{
            return "nui-ico-file nui-ico-file-default";
        }
    }
    /**
     *  获取操作系统文件路径分隔符
     */
    public static String getSep(){
        return System.getProperties().getProperty("file.separator");
    }
    /**
     * 检查文件路径是否有效
     * @param path
     * @return
     */
    public static void checkPath(String path) throws IOException{
        File filePath = new File(path);
        if(!filePath.exists()){
            throw new IOException("无效的文件路径【" + path + "】;");
        }
    }
    /**
     * 创建目录
     * @param group
     * @param file
     * @return
     */
    public static File getDoccenterDir(String doccenterPath, String group,String file) throws IOException{
        File folder = new File(doccenterPath);
        FileUtils.checkPath(folder.getAbsolutePath());
        if(!folder.exists()){
            folder.mkdir();
        }
        folder = new File(folder.getAbsoluteFile() + FileUtils.getSep() +"group" + group);
        if(!folder.exists()){
            folder.mkdir();
        }
        folder = new File(folder.getAbsoluteFile() + FileUtils.getSep() +"file" + file);
        if(!folder.exists()){
            folder.mkdir();
        }
        return folder.getAbsoluteFile();
    }

    public static File getDoccenterDir(String doccenterPath, String tmpId) throws IOException{
        File folder = new File(doccenterPath);
        FileUtils.checkPath(folder.getAbsolutePath());
        if(!folder.exists()){
            folder.mkdir();
        }
        folder = new File(folder.getAbsoluteFile() + FileUtils.getSep() +"tmp" + tmpId);
        if(!folder.exists()){
            folder.mkdir();
        }
        return folder.getAbsoluteFile();
    }
    /**
     * 单位形式，显示文件大小
     * @param fileSize
     * @return
     */
    public static String getFilePrettySize(Long fileSize){
        long K = 1024;
        long M = K * K;
        long G = M * K;
        long T = G * K;
        long[] dividers = { T, G, M, K, 1 };
        String[] units = { "TB", "GB", "MB", "KB", "B" };
        if (fileSize == 0) {
            return "0B";
        } else if (fileSize < 0) {
            return "Invalid size";
        }

        String result = "";
        long temp = 0;
        for ( int i = 0; i < dividers.length; i++) {
            long divider = dividers[i];
            if (fileSize >= divider) {
                temp = fileSize / divider;
                if (temp < 1.05) {
                    result = _format(fileSize,units[((i + 1) < units.length) ? (i + 1) : i]);
                } else {
                    result = _format(temp, units[i]);
                }
                break;
            }
        }
        return result;
    }
    private static String _format(Long fileSize, String unit) {
        return (fileSize + " " + unit).replace(".0", "");
    }

	/*public static String getFileName(String fileName, String agent) {
		String codedfilename = fileName;
		try {
			if (agent != null && agent.indexOf("Mozilla") != -1 && agent.indexOf("Android") != -1) {// Mozilla..
				try {
					codedfilename = URLEncoder.encode(fileName, "UTF-8");
				} catch (Exception e) {
					codedfilename = fileName;
				}
			} else if (agent.toLowerCase().indexOf("safari") != -1) {// Safari浏览器，只能采用ISO编码的中文输出
				codedfilename = new String(codedfilename.getBytes("UTF-8"), "ISO8859-1");
			} else if (agent.toLowerCase().indexOf("chrome") != -1) {// Chrome浏览器，只能采用MimeUtility编码或ISO编码的中文输出
				codedfilename = MimeUtility.encodeText(codedfilename, "UTF8", "B");
			}
			// FireFox浏览器，可以使用MimeUtility或filename*或ISO编码的中文输出
			else if (agent != null && agent.toLowerCase().indexOf("mozilla") != -1 && agent.toLowerCase().indexOf("firefox") != -1) {// ff,mozilla..
				codedfilename = MimeUtility.encodeText(fileName, "GBK", "B");
			} else {// ie,opera..
				if (Charset.defaultCharset().name().indexOf("GBK") != -1) {
					codedfilename = new String(fileName.getBytes(), "ISO8859_1");
				} else {
					try {
						codedfilename = URLEncoder.encode(fileName, "utf-8");
					} catch (Exception e) {
						throw new RuntimeException(e);
					}
				}
			}

		} catch (Exception e) {

		}
		return codedfilename;
	}*/


    public static byte[] InputStreamToByte(InputStream is) throws IOException {

        ByteArrayOutputStream bytestream = new ByteArrayOutputStream();
        int ch;
        while ((ch = is.read()) != -1) {
            bytestream.write(ch);
        }
        byte imgdata[] = bytestream.toByteArray();
        bytestream.close();

        return imgdata;
    }
}
