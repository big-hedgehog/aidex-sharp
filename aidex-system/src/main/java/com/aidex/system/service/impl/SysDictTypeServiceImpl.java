package com.aidex.system.service.impl;

import com.aidex.common.core.service.BaseServiceImpl;
import com.aidex.common.exception.BizException;
import com.aidex.common.exception.CustomException;
import com.aidex.framework.cache.DictUtils;
import com.aidex.system.common.SysErrorCode;
import com.aidex.system.domain.SysDictData;
import com.aidex.system.domain.SysDictType;
import com.aidex.system.mapper.SysDictDataMapper;
import com.aidex.system.mapper.SysDictTypeMapper;
import com.aidex.system.service.SysDictTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import java.util.ArrayList;
import java.util.List;

/**
 * 字典 业务层处理
 * 
 * @author ruoyi
 */
@Service
public class SysDictTypeServiceImpl extends BaseServiceImpl<SysDictTypeMapper, SysDictType> implements SysDictTypeService
{

    @Autowired
    private SysDictDataMapper sysDictDataMapper;
    /**
     * 项目启动时，初始化字典到缓存
     */
    /**
     * 启动的时候不加载缓存信息
    @PostConstruct
    public void init()
    {
        List<SysDictType> dictTypeList = dictTypeMapper.selectDictTypeAll();
        for (SysDictType dictType : dictTypeList)
        {
            List<SysDictData> dictDatas = dictDataMapper.selectDictDataByType(dictType.getDictType());
            DictUtils.setDictCache(dictType.getDictType(), dictDatas);
        }
    }
    **/


    /**
     * 根据字典类型查询字典数据
     * 
     * @param dictType 字典类型
     * @return 字典数据集合信息
     */
    @Override
    public List<SysDictData> selectDictDataByType(String dictType)
    {
        return DictUtils.getDictList(dictType);
    }

    /**
     * 根据字典类型查询字典数据
     *
     * @param dictType 字典类型
     * @return 字典数据集合信息
     */
    @Override
    public List<SysDictData> selectAllDictDataByType(String dictType)
    {
        return DictUtils.getAllDictList(dictType);
    }


    /**
     * 根据字典类型查询信息
     * 
     * @param dictType 字典类型
     * @return 字典类型
     */
    @Override
    public SysDictType selectDictTypeByType(String dictType)
    {
        SysDictType SysDictType = new SysDictType();
        SysDictType.setDictType(dictType);
        List<SysDictType> list = mapper.findList(SysDictType);
        if(!CollectionUtils.isEmpty(list)){
            return list.get(0);
        }
        return null;
    }

    /**
     * 批量删除字典类型信息
     * 
     * @param dictIds 需要删除的字典ID
     * @return 结果
     */
    @Override
    @Transactional(readOnly = false)
    public int deleteDictTypeByIds(String[] dictIds)
    {
        for (String dictId : dictIds)
        {
            SysDictType dictType = get(dictId);
            SysDictData sysDictData = new SysDictData();
            sysDictData.setDictType(dictType.getDictType());
            List<SysDictData> dictDataList = sysDictDataMapper.findList(sysDictData);
            if (dictDataList.size() > 0)
            {
                throw new CustomException(String.format("%1$s已分配,不能删除", dictType.getDictName()));
            }
        }
        int count = mapper.deleteDictTypeByIds(dictIds,SysDictType.DEL_FLAG_DELETE);
        if (count > 0)
        {
            DictUtils.clearDictCache();
        }
        return count;
    }

    /**
     * 清空缓存数据
     */
    @Override
    public void clearCache()
    {
        DictUtils.clearDictCache();
    }

    /**
     * 新增保存字典类型信息
     * 
     * @param dictType 字典类型信息
     * @return 结果
     */
    @Override
    public boolean save(SysDictType dictType)
    {
        boolean result = super.save(dictType);
        if (result)
        {
            DictUtils.clearDictCache();
        }
        return result;
    }

    /**
     * 校验字典类型称是否唯一
     * 
     * @param dict 字典类型
     * @return 结果
     */
    @Override
    public void checkDictTypeUnique(SysDictType dict)
    {
        SysDictType sysDictTypeUnique = new SysDictType();
        sysDictTypeUnique.setNotEqualId(dict.getId());
        sysDictTypeUnique.setDictType(dict.getDictType());
        if (!CollectionUtils.isEmpty(mapper.findListWithUnique(sysDictTypeUnique))) {
            throw new BizException(SysErrorCode.B_SYSDICTTYPE_DictTypeAlreadyExist);
        }
    }
}
