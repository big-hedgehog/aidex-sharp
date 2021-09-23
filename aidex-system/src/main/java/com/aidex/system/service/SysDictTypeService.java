package com.aidex.system.service;

import com.aidex.common.core.service.BaseService;
import com.aidex.system.domain.SysDictData;
import com.aidex.system.domain.SysDictType;

import java.util.List;

/**
 * 字典 业务层
 * 
 * @author ruoyi
 */
public interface SysDictTypeService extends BaseService<SysDictType>
{

    /**
     * 根据字典类型查询字典数据
     * 
     * @param dictType 字典类型
     * @return 字典数据集合信息
     */
    public List<SysDictData> selectDictDataByType(String dictType);


    /**
     * 根据字典类型查询字典数据
     *
     * @param dictType 字典类型
     * @return 字典数据集合信息
     */
    public List<SysDictData> selectAllDictDataByType(String dictType);



    /**
     * 根据字典类型查询信息
     * 
     * @param dictType 字典类型
     * @return 字典类型
     */
    public SysDictType selectDictTypeByType(String dictType);

    /**
     * 批量删除字典信息
     * 
     * @param dictIds 需要删除的字典ID
     * @return 结果
     */
    public int deleteDictTypeByIds(String[] dictIds);

    /**
     * 清空缓存数据
     */
    public void clearCache();


    /**
     * 校验字典类型称是否唯一
     * 
     * @param dictType 字典类型
     * @return 结果
     */
    public void checkDictTypeUnique(SysDictType dictType);
}
