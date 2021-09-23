package com.aidex.generator.util;

import java.io.File;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

import com.aidex.common.core.domain.entity.SysMenu;
import com.aidex.common.exception.CustomException;
import com.aidex.common.utils.spring.SpringUtils;
import com.aidex.common.utils.uuid.IdUtils;
import com.aidex.system.service.SysMenuService;
import org.apache.velocity.VelocityContext;
import com.alibaba.fastjson.JSONObject;
import com.aidex.common.constant.GenConstants;
import com.aidex.common.utils.DateUtils;
import com.aidex.common.utils.StringUtils;
import com.aidex.generator.domain.GenTable;
import com.aidex.generator.domain.GenTableColumn;
import org.springframework.util.ObjectUtils;

/**
 * 模板处理工具类
 *
 * @author ruoyi
 */
public class VelocityUtils {
    /**
     * 项目空间路径
     */
    private static final String PROJECT_PATH = "src/main/java";

    /**
     * 默认上级菜单，系统工具
     */
    private static final String DEFAULT_PARENT_MENU_ID = "3";

    /**
     * 默认上传附件配置
     */
    private static final String DEFAULT_ATTACH_SET = "0";

    /**
     * 默认是否有停用启用配置
     */
    private static final String DEFAULT_DISABLE_ENABLE_SET = "0";

    /**
     * 设置模板变量信息
     *
     * @return 模板列表
     */
    public static VelocityContext prepareContext(GenTable genTable) {
        String moduleName = genTable.getModuleName();
        String packageName = genTable.getPackageName();
        String tplCategory = genTable.getTplCategory();
        String functionName = genTable.getFunctionName();

        if(StringUtils.isEmpty(moduleName)){
            throw new CustomException("请先选择该表的生成模块等信息");
        }

        if(StringUtils.isEmpty(packageName)){
            throw new CustomException("请先选择该表的生成模块等信息");
        }

        if(StringUtils.isEmpty(tplCategory)){
            throw new CustomException("请先选择该表的生成模板信息");
        }

        if(StringUtils.isEmpty(functionName)){
            throw new CustomException("请先选择该表的生成功能等信息");
        }

        VelocityContext velocityContext = new VelocityContext();
        velocityContext.put("tplCategory", genTable.getTplCategory());
        velocityContext.put("tableName", genTable.getTableName());
        velocityContext.put("tableNameUnderline", genTable.getTableName().replaceAll("_", "-"));
        velocityContext.put("ClassName", genTable.getClassName());
        velocityContext.put("className", StringUtils.uncapitalize(genTable.getClassName()));
        velocityContext.put("moduleName", genTable.getModuleName());
        String BusinessName = StringUtils.capitalize(vueFileNameFormat(genTable.getTableName()));
        String businessName = StringUtils.uncapitalize(vueFileNameFormat(genTable.getTableName()));
        String parentBusinessName = genTable.getBusinessName();
        velocityContext.put("ParentBusinessName", StringUtils.capitalize(parentBusinessName));
        velocityContext.put("parentBusinessName", StringUtils.uncapitalize(parentBusinessName));
        velocityContext.put("BusinessName", BusinessName);
        velocityContext.put("businessName", businessName);
        velocityContext.put("businessNameLowerCase", genTable.getBusinessName().toLowerCase());
        velocityContext.put("basePackage", getPackagePrefix(packageName));
        velocityContext.put("packageName", packageName);
        velocityContext.put("functionAuthor", genTable.getFunctionAuthor());
        velocityContext.put("functionAuthorEmail", genTable.getFunctionAuthorEmail());
        velocityContext.put("datetime", DateUtils.getDate());
        velocityContext.put("pkColumn", genTable.getPkColumn());
        velocityContext.put("importList", getImportList(genTable));
        velocityContext.put("permissionPrefix", getPermissionPrefix(moduleName, businessName));
        velocityContext.put("columns", genTable.getColumns());

        velocityContext.put("uniqueColumns", genTable.getColumns().stream().filter(column -> column.isUnique()).collect(Collectors.toList()));
        velocityContext.put("listColumns", genTable.getColumns().stream().filter(column -> column.isList()).collect(Collectors.toList()));
        velocityContext.put("requireColumns", genTable.getColumns().stream().filter(column -> column.isRequired()).collect(Collectors.toList()));
        velocityContext.put("dictColumns", genTable.getColumns().stream().filter(column -> StringUtils.isNotEmpty(column.getDictType())).collect(Collectors.toList()));
        velocityContext.put("queryColumns", genTable.getColumns().stream().filter(column -> (column.isQuery())).collect(Collectors.toList()));
        velocityContext.put("dateColumns", genTable.getColumns().stream().filter(column -> column.getJavaType().equals(GenConstants.TYPE_DATE)).collect(Collectors.toList()));
        velocityContext.put("editColumns", genTable.getColumns().stream().filter(column -> column.isEdit()).collect(Collectors.toList()));
        //转换option中信息到对象
        setTableFromOptions(genTable);

        velocityContext.put("table", genTable);
        //是否包含附件
        velocityContext.put("hasAttach", genTable.hasAttach());
        //是否有停用启用
        velocityContext.put("hasDisableEnable", genTable.hasDisableEnable());
        boolean isSub = isSub(genTable);
        velocityContext.put("hasSubParam", !isSub && (GenConstants.TPL_SUB.equals(tplCategory) || GenConstants.TPL_TREE.equals(tplCategory)));
        velocityContext.put("isSub", isSub);

        // 判断是否主子表，子表不需要菜单变量
        if(!isSub){
            velocityContext.put("functionName", StringUtils.isNotEmpty(functionName) ? functionName : "【请填写功能名称】");
            setMenuVelocityContext(velocityContext, genTable);
            if (GenConstants.TPL_SUB.equals(tplCategory)) {
                setSubVelocityContext(velocityContext, genTable);
                String subTableJavaName = vueFileNameFormat(genTable.getSubTable().getTableName());
                //子表名的java名称，首字母大写
                velocityContext.put("subTableJavaNameCap", StringUtils.capitalize(subTableJavaName));
                //子表名的java名称，首字母小写
                velocityContext.put("subTableJavaNameUnCap", StringUtils.uncapitalize(subTableJavaName));
                //子表名的组件名，类似于subtable-index
                velocityContext.put("subComponentName", vueComponentFileNameFormat(StringUtils.uncapitalize(subTableJavaName)));
                //外键字段的java名称，首字母大写
                velocityContext.put("subTableFkNameCap", StringUtils.capitalize(vueFileNameFormat(genTable.getSubTableFkName())));
            }else{
                //组件名，类似于table-index
                velocityContext.put("componentName", vueComponentFileNameFormat(StringUtils.uncapitalize(parentBusinessName)));
            }
        }else{
            velocityContext.put("functionName", StringUtils.isNotEmpty(functionName) ? functionName+"子表" : "【请填写功能名称】");
        }
        //外键字段
        velocityContext.put("subTableFkName", genTable.getSubTableFkName());
        //外键字段的java名称，首字母大写
        if(StringUtils.isNotEmpty(genTable.getSubTableFkName())){
            velocityContext.put("subTableFkNameUnCap", StringUtils.uncapitalize(vueFileNameFormat(genTable.getSubTableFkName())));
        }

        if (GenConstants.TPL_TREEGRID.equals(tplCategory) || GenConstants.TPL_TREE.equals(tplCategory)) {
            setTreeVelocityContext(velocityContext, genTable);
        }

        return velocityContext;
    }

    /**
     * 将驼峰格式名称转化为带-的名字，类似将UserIndex转化为user-index
     * @param name
     * @return
     */
    public static String vueComponentFileNameFormat(String name){
        String patternExp = "([A-Z])";
        Pattern p = Pattern.compile( patternExp );
        Matcher m = p.matcher( name );
        StringBuffer sb = new StringBuffer();
        while (m.find()) {
            m.appendReplacement(sb, "-" + m.group(1).toLowerCase());
        }
        m.appendTail(sb);
        return sb.toString();
    }

    /**
     * 将表名称转化为驼峰格式名称的名字，类似将user_data转化为userData
     * @param name
     * @return
     */
    public static String vueFileNameFormat(String name){
        String patternExp = "_([a-zA-Z])";
        Pattern p = Pattern.compile( patternExp );
        Matcher m = p.matcher( name );
        StringBuffer sb = new StringBuffer();
        while (m.find()) {
            m.appendReplacement(sb, m.group(1).toUpperCase());
        }
        m.appendTail(sb);
        return sb.toString();
    }

    public static boolean isSub(GenTable genTable){
        GenTable sub = genTable.getSubTable();
        String tplCategory = genTable.getTplCategory();
        if(sub == null && (GenConstants.TPL_SUB.equals(tplCategory) || GenConstants.TPL_TREE.equals(tplCategory))){
            return true;
        }
        return false;
    }
    public static void setMenuVelocityContext(VelocityContext context, GenTable genTable) {
        //String options = genTable.getOptions();
        //JSONObject paramsObj = JSONObject.parseObject(options);
        // 父节点ID
        //String parentMenuId = getParentMenuId(paramsObj);
        // 菜单图标
        /*String menuIcon = ObjectUtils.getDisplayString(paramsObj.getString(GenConstants.MENU_ICON));
        if(StringUtils.isEmpty(menuIcon)){
            menuIcon = "#";
        }*/
        SysMenuService sysMenuService = SpringUtils.getBean(SysMenuService.class);
        SysMenu parentMenu = sysMenuService.get(genTable.getParentMenuId());
        if (parentMenu == null) {
            throw new CustomException("代码生成所选择的父菜单不存在！请重新选择菜单");
        }
        SysMenu menuQuery = new SysMenu();
        menuQuery.setParentId(parentMenu.getId());
        int sysMenuSort = sysMenuService.findMaxSort(menuQuery);

        //父节点是否是叶子节点
        context.put("parentSysMenu_treeLeaf", parentMenu.getTreeLeaf());
        context.put("menuIcon", genTable.getMenuIcon());

        //菜单信息初始化
        String sysMenuId = IdUtils.randomUUID();
        context.put("sysMenu_id", sysMenuId);
        context.put("sysMenu_menuCode", context.get("businessName"));
        context.put("sysMenu_menuName", context.get("functionName"));
        context.put("sysMenu_sort", sysMenuSort);
        context.put("sysMenu_path", context.get("businessName"));
        context.put("sysMenu_component", context.get("moduleName") + "/" + context.get("businessNameLowerCase") + "/index");
        context.put("sysMenu_parentId", genTable.getParentMenuId());
        context.put("sysMenu_parentIds", parentMenu.getParentIds() + "/" + sysMenuId);
        context.put("sysMenu_treeSort", sysMenuSort);
        context.put("sysMenu_treeSorts", parentMenu.getTreeSorts() + "/" + sysMenuSort);
        context.put("sysMenu_treeLevel", parentMenu.getTreeLevel() + 1);

        // 查询按钮
        String sysMenuIdQuery = IdUtils.randomUUID();
        context.put("sysMenu_id_query", sysMenuIdQuery);
        context.put("sysMenu_sort_query", 10);
        context.put("sysMenu_parentIds_query", parentMenu.getParentIds() + "/" + sysMenuId+ "/" + sysMenuIdQuery);
        context.put("sysMenu_treeSort_query", 10);
        context.put("sysMenu_treeSorts_query", parentMenu.getTreeSorts() + "/" + sysMenuSort + "/" + 10);
        context.put("sysMenu_treeLevel_query", parentMenu.getTreeLevel() + 1 + 1);

        // 添加按钮
        String sysMenuIdAdd = IdUtils.randomUUID();
        context.put("sysMenu_id_add", sysMenuIdAdd);
        context.put("sysMenu_sort_add", 20);
        context.put("sysMenu_parentIds_add", parentMenu.getParentIds() + "/" + sysMenuId+ "/" + sysMenuIdAdd);
        context.put("sysMenu_treeSort_add", 20);
        context.put("sysMenu_treeSorts_add", parentMenu.getTreeSorts() + "/" + sysMenuSort + "/" + 20);
        context.put("sysMenu_treeLevel_add", parentMenu.getTreeLevel() + 1 + 1);

        // 编辑按钮
        String sysMenuIdEdit = IdUtils.randomUUID();
        context.put("sysMenu_id_edit", sysMenuIdEdit);
        context.put("sysMenu_sort_edit", 30);
        context.put("sysMenu_parentIds_edit", parentMenu.getParentIds() + "/" + sysMenuId+ "/" + sysMenuIdEdit);
        context.put("sysMenu_treeSort_edit", 30);
        context.put("sysMenu_treeSorts_edit", parentMenu.getTreeSorts() + "/" + sysMenuSort + "/" + 30);
        context.put("sysMenu_treeLevel_edit", parentMenu.getTreeLevel() + 1 + 1);

        // 删除按钮
        String sysMenuIdRemove = IdUtils.randomUUID();
        context.put("sysMenu_id_remove", sysMenuIdRemove);
        context.put("sysMenu_sort_remove", 40);
        context.put("sysMenu_parentIds_remove", parentMenu.getParentIds() + "/" + sysMenuId+ "/" + sysMenuIdRemove);
        context.put("sysMenu_treeSort_remove", 40);
        context.put("sysMenu_treeSorts_remove", parentMenu.getTreeSorts() + "/" + sysMenuSort + "/" + 40);
        context.put("sysMenu_treeLevel_remove", parentMenu.getTreeLevel() + 1 + 1);

        // 导出按钮
        String sysMenuIdExport = IdUtils.randomUUID();
        context.put("sysMenu_id_export", sysMenuIdExport);
        context.put("sysMenu_sort_export", 50);
        context.put("sysMenu_parentIds_export", parentMenu.getParentIds() + "/" + sysMenuId+ "/" + sysMenuIdExport);
        context.put("sysMenu_treeSort_export", 50);
        context.put("sysMenu_treeSorts_export", parentMenu.getTreeSorts() + "/" + sysMenuSort + "/" + 50);
        context.put("sysMenu_treeLevel_export", parentMenu.getTreeLevel() + 1 + 1);

        //查看父节点，如果父节点是叶子节点，则需要更新为非叶子节点
        if("y".equals(parentMenu.getTreeLeaf())){
            parentMenu.setTreeLeaf("n");
            sysMenuService.save(parentMenu);
        }


    }

    public static void setTreeVelocityContext(VelocityContext context, GenTable genTable) {
        String options = genTable.getOptions();
        JSONObject paramsObj = JSONObject.parseObject(options);
        //String treeCode = getTreecode(paramsObj);
        //String treeParentCode = getTreeParentCode(paramsObj);
        //String treeName = getTreeName(paramsObj);
        //context.put("treeCode", genTable.getTreeCode());
        //String treeCodeCap = StringUtils.capitalize(genTable.getTreeCode());
        //context.put("treeCodeCap", treeCodeCap);
        //context.put("treeParentCode", genTable.getTreeParentCode());
        //String treeParentCodeCap = StringUtils.capitalize(genTable.getTreeParentCode());
        //context.put("treeParentCodeCap", treeParentCodeCap);
        context.put("treeName", genTable.getTreeName());
        context.put("expandColumn", getExpandColumn(genTable));
        if (paramsObj.containsKey(GenConstants.TREE_PARENT_CODE)) {
            context.put("tree_parent_code", paramsObj.getString(GenConstants.TREE_PARENT_CODE));
        }
        if (paramsObj.containsKey(GenConstants.TREE_NAME)) {
            context.put("tree_name", paramsObj.getString(GenConstants.TREE_NAME));
        }
    }

    public static void setSubVelocityContext(VelocityContext context, GenTable genTable) {
        GenTable subTable = genTable.getSubTable();
        String subTableName = genTable.getSubTableName();
        String subTableFkName = genTable.getSubTableFkName();
        String subClassName = genTable.getSubTable().getClassName();
        String subTableFkClassName = StringUtils.convertToCamelCase(subTableFkName);

        context.put("subTable", subTable);
        context.put("subTableName", subTableName);
        context.put("subTableFkName", subTableFkName);
        context.put("subTableFkClassName", subTableFkClassName);
        context.put("subTableFkclassName", StringUtils.uncapitalize(subTableFkClassName));
        context.put("subClassName", subClassName);
        context.put("subclassName", StringUtils.uncapitalize(subClassName));
        context.put("subImportList", getImportList(genTable.getSubTable()));
    }

    /**
     * 获取模板信息
     *
     * @return 模板列表
     */
    public static List<String> getTemplateList(String tplCategory) {
        List<String> templates = new ArrayList<String>();
        if (GenConstants.TPL_CRUD.equals(tplCategory) || GenConstants.TPL_SUB.equals(tplCategory)) {
            templates.add("vm/crud/vue/index.vue.vm");
            templates.add("vm/crud/vue/api.js.vm");
            templates.add("vm/crud/vue/addForm.vue.vm");
            templates.add("vm/crud/vue/editForm.vue.vm");
            templates.add("vm/crud/vue/form.js.vm");
            templates.add("vm/crud/sql.vm");
            templates.add("vm/crud/controller.java.vm");
            templates.add("vm/crud/service.java.vm");
            templates.add("vm/crud/serviceImpl.java.vm");
            templates.add("vm/crud/domain.java.vm");
            templates.add("vm/crud/mapper.java.vm");
            templates.add("vm/crud/mapper.xml.vm");
        } else if (GenConstants.TPL_TREE.equals(tplCategory)) {
            templates.add("vm/tree/controller.java.vm");
            templates.add("vm/tree/service.java.vm");
            templates.add("vm/tree/serviceImpl.java.vm");
            templates.add("vm/tree/domain.java.vm");
            templates.add("vm/tree/mapper.java.vm");
            templates.add("vm/tree/mapper.xml.vm");
            templates.add("vm/tree/vue/tree-index.vue.vm");
            templates.add("vm/tree/vue/api.js.vm");
            templates.add("vm/tree/vue/addForm.vue.vm");
            templates.add("vm/tree/vue/editForm.vue.vm");
            templates.add("vm/tree/vue/tree.vue.vm");
            templates.add("vm/tree/vue/form.js.vm");
            templates.add("vm/tree/sql.vm");
        } else if (GenConstants.TPL_TREEGRID.equals(tplCategory)) {
            templates.add("vm/treegrid/controller.java.vm");
            templates.add("vm/treegrid/service.java.vm");
            templates.add("vm/treegrid/serviceImpl.java.vm");
            templates.add("vm/treegrid/domain.java.vm");
            templates.add("vm/treegrid/mapper.java.vm");
            templates.add("vm/treegrid/mapper.xml.vm");
            templates.add("vm/treegrid/vue/index.vue.vm");
            templates.add("vm/treegrid/vue/api.js.vm");
            templates.add("vm/treegrid/vue/addForm.vue.vm");
            templates.add("vm/treegrid/vue/editForm.vue.vm");
            templates.add("vm/treegrid/vue/form.js.vm");
            templates.add("vm/treegrid/sql.vm");
        }
        return templates;
    }

    /**
     * 获取文件名
     */
    public static String getFileName(String template, GenTable genTable) {
        // 文件名称
        String fileName = "";
        // 包路径
        String packageName = genTable.getPackageName();
        // 模块名
        String moduleName = genTable.getModuleName();
        // 大写类名
        String className = genTable.getClassName();
        // 业务名称
        String businessName = genTable.getBusinessName();

        String businessNameLowerCase = genTable.getBusinessName().toLowerCase();

        String BusinessName = StringUtils.capitalize(vueFileNameFormat(genTable.getTableName()));

        boolean isSub = VelocityUtils.isSub(genTable);

        String workSpace = genTable.getWorkspacePath();
        String javaPath = workSpace + File.separator + PROJECT_PATH + File.separator + StringUtils.replace(packageName, ".", File.separator);
        String vueWorkspacePath = genTable.getWebWorkspacePath();
        if (template.contains("domain.java.vm")) {
            fileName = StringUtils.format("{}/domain/{}.java", javaPath, className);
        }
        if (template.contains("sub-domain.java.vm") && StringUtils.equals(GenConstants.TPL_SUB, genTable.getTplCategory())) {
            fileName = StringUtils.format("{}/domain/{}.java", javaPath, genTable.getSubTable().getClassName());
        } else if (template.contains("mapper.java.vm")) {
            fileName = StringUtils.format("{}/mapper/{}Mapper.java", javaPath, className);
        } else if (template.contains("service.java.vm")) {
            fileName = StringUtils.format("{}/service/{}Service.java", javaPath, className);
        } else if (template.contains("serviceImpl.java.vm")) {
            fileName = StringUtils.format("{}/service/impl/{}ServiceImpl.java", javaPath, className);
        } else if (template.contains("controller.java.vm")) {
            fileName = StringUtils.format("{}/controller/{}Controller.java", javaPath, className);
        } else if (template.contains("mapper.xml.vm")) {
            fileName = StringUtils.format("{}/mapper/{}Mapper.xml", javaPath, className);
        } else if (template.contains("sql.vm")) {
            fileName = "sql" + "/" + BusinessName + "Menu.sql";
        } else if (template.contains("api.js.vm")) {
            fileName = StringUtils.format("{}/src/api/{}/{}.js", vueWorkspacePath, moduleName, StringUtils.uncapitalize(vueFileNameFormat(genTable.getTableName())));
        } else if(template.contains("tree-index.vue.vm")){
            fileName = StringUtils.format("{}/src/views/{}/{}/index.vue", vueWorkspacePath, moduleName, businessNameLowerCase);
        } else if(template.contains("tree.vue.vm")){
            fileName = StringUtils.format("{}/src/views/{}/{}/modules/{}Tree.vue", vueWorkspacePath, moduleName, businessNameLowerCase, BusinessName);
        }else if(template.contains("sub-index.vue.vm")){
            fileName = StringUtils.format("{}/src/views/{}/{}/{}Index.vue", vueWorkspacePath, moduleName, businessNameLowerCase, BusinessName);
        } else if (template.contains("index.vue.vm")) {
            if (isSub) {
                fileName = StringUtils.format("{}/src/views/{}/{}/{}Index.vue", vueWorkspacePath, moduleName, businessNameLowerCase, BusinessName);
            } else {
                fileName = StringUtils.format("{}/src/views/{}/{}/index.vue", vueWorkspacePath, moduleName, businessNameLowerCase);
            }
        }  else if (template.contains("addForm.vue.vm")) {
            fileName = StringUtils.format("{}/src/views/{}/{}/modules/{}AddForm.vue", vueWorkspacePath, moduleName, businessNameLowerCase, BusinessName);
        } else if (template.contains("editForm.vue.vm")) {
            fileName = StringUtils.format("{}/src/views/{}/{}/modules/{}EditForm.vue", vueWorkspacePath, moduleName, businessNameLowerCase, BusinessName);
        } else if (template.contains("form.js.vm")) {
            fileName = StringUtils.format("{}/src/views/{}/{}/modules/{}Form.js", vueWorkspacePath, moduleName, businessNameLowerCase, BusinessName);
        } else if (template.contains("index-tree.vue.vm")) {
            fileName = StringUtils.format("{}/views/{}/{}/index.vue", vueWorkspacePath, moduleName, BusinessName);
        }
        return fileName;
    }

    /**
     * 获取包前缀
     *
     * @param packageName 包名称
     * @return 包前缀名称
     */
    public static String getPackagePrefix(String packageName) {
        int lastIndex = packageName.lastIndexOf('.');
        String basePackage = StringUtils.substring(packageName, 0, lastIndex);
        return basePackage;
    }

    /**
     * 根据列类型获取导入包
     *
     * @param genTable 业务表对象
     * @return 返回需要导入的包列表
     */
    public static HashSet<String> getImportList(GenTable genTable) {
        List<GenTableColumn> columns = genTable.getColumns();
        GenTable subGenTable = genTable.getSubTable();
        HashSet<String> importList = new HashSet<String>();
        if (StringUtils.isNotNull(subGenTable)) {
            importList.add("java.util.List");
        }
        for (GenTableColumn column : columns) {
            if (!column.isSuperColumn() && GenConstants.TYPE_DATE.equals(column.getJavaType())) {
                importList.add("java.util.Date");
                importList.add("com.fasterxml.jackson.annotation.JsonFormat");
            } else if (!column.isSuperColumn() && GenConstants.TYPE_BIGDECIMAL.equals(column.getJavaType())) {
                importList.add("java.math.BigDecimal");
            }
            if (column.isRequired() && "string".equals(column.getJavaType().toLowerCase())) {
                importList.add("javax.validation.Valid");
                importList.add("javax.validation.constraints.NotBlank");
            }
        }
        return importList;
    }

    /**
     * 获取权限前缀
     *
     * @param moduleName   模块名称
     * @param businessName 业务名称
     * @return 返回权限前缀
     */
    public static String getPermissionPrefix(String moduleName, String businessName) {
        return StringUtils.format("{}:{}", moduleName, businessName);
    }

    /**
     * 获取上级菜单ID字段
     *
     * @param paramsObj 生成其他选项
     * @return 上级菜单ID字段
     */
    public static String getParentMenuId(JSONObject paramsObj) {
        if (StringUtils.isNotEmpty(paramsObj) && paramsObj.containsKey(GenConstants.PARENT_MENU_ID)) {
            return paramsObj.getString(GenConstants.PARENT_MENU_ID);
        }
        return DEFAULT_PARENT_MENU_ID;
    }

    /**
     * 获取是否可上传附件配置
     *
     * @param paramsObj 生成其他选项
     * @return 是否可上传附件配置
     */
    public static String getAttachOption(JSONObject paramsObj) {
        if (StringUtils.isNotEmpty(paramsObj) && paramsObj.containsKey(GenConstants.ATTACH_OPTION)) {
            return paramsObj.getString(GenConstants.ATTACH_OPTION);
        }
        return DEFAULT_ATTACH_SET;
    }

    /**
     * 获取是否有停用启用配置
     *
     * @param paramsObj 生成其他选项
     * @return 获取是否有停用启用配置
     */
    public static String getDisableEnableOption(JSONObject paramsObj) {
        if (StringUtils.isNotEmpty(paramsObj) && paramsObj.containsKey(GenConstants.DISABLE_ENABLE_OPTION)) {
            return paramsObj.getString(GenConstants.DISABLE_ENABLE_OPTION);
        }
        return DEFAULT_DISABLE_ENABLE_SET;
    }

    /**
     * 获取树编码
     *
     * @param paramsObj 生成其他选项
     * @return 树编码
     */
    public static String getTreecode(JSONObject paramsObj) {
        if (paramsObj.containsKey(GenConstants.TREE_CODE)) {
            return StringUtils.toCamelCase(paramsObj.getString(GenConstants.TREE_CODE));
        }
        return StringUtils.EMPTY;
    }

    /**
     * 获取树父编码
     *
     * @param paramsObj 生成其他选项
     * @return 树父编码
     */
    public static String getTreeParentCode(JSONObject paramsObj) {
        if (paramsObj.containsKey(GenConstants.TREE_PARENT_CODE)) {
            return StringUtils.toCamelCase(paramsObj.getString(GenConstants.TREE_PARENT_CODE));
        }
        return StringUtils.EMPTY;
    }

    /**
     * 获取树名称
     *
     * @param paramsObj 生成其他选项
     * @return 树名称
     */
    public static String getTreeName(JSONObject paramsObj) {
        if (paramsObj.containsKey(GenConstants.TREE_NAME)) {
            return StringUtils.toCamelCase(paramsObj.getString(GenConstants.TREE_NAME));
        }
        return StringUtils.EMPTY;
    }

    /**
     * 获取需要在哪一列上面显示展开按钮
     *
     * @param genTable 业务表对象
     * @return 展开按钮列序号
     */
    public static int getExpandColumn(GenTable genTable) {
        String options = genTable.getOptions();
        JSONObject paramsObj = JSONObject.parseObject(options);
        String treeName = paramsObj.getString(GenConstants.TREE_NAME);
        int num = 0;
        for (GenTableColumn column : genTable.getColumns()) {
            if (column.isList()) {
                num++;
                String columnName = column.getColumnName();
                if (columnName.equals(treeName)) {
                    break;
                }
            }
        }
        return num;
    }


    /**
     * 设置代码生成其他选项值
     *
     * @param genTable 设置后的生成对象
     */
    public static void setTableFromOptions(GenTable genTable) {
        JSONObject paramsObj = JSONObject.parseObject(genTable.getOptions());
        if (StringUtils.isNotNull(paramsObj)) {

            String treeCode = getTreecode(paramsObj);;
            String treeParentCode = getTreeParentCode(paramsObj);
            String treeName = getTreeName(paramsObj);
            String parentMenuId = getParentMenuId(paramsObj);

            String parentMenuName = paramsObj.getString(GenConstants.PARENT_MENU_NAME);

            String menuIcon = ObjectUtils.getDisplayString(paramsObj.getString(GenConstants.MENU_ICON));
            if(StringUtils.isEmpty(menuIcon)){
                menuIcon = "#";
            }
            String attachOption = getAttachOption(paramsObj);
            String disableEnableOption = getDisableEnableOption(paramsObj);
            genTable.setTreeCode(treeCode);
            genTable.setTreeParentCode(treeParentCode);
            genTable.setTreeName(treeName);
            genTable.setParentMenuId(parentMenuId);
            genTable.setParentMenuName(parentMenuName);
            genTable.setMenuIcon(menuIcon);
            genTable.setAttachOption(attachOption);
            genTable.setDisableEnableOption(disableEnableOption);
        }
    }
}
