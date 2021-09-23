package com.aidex.system.service.impl;

import com.aidex.common.core.domain.BaseEntity;
import com.aidex.common.core.service.BaseServiceImpl;
import com.aidex.common.exception.BizException;
import com.aidex.common.utils.NumberUtils;
import com.aidex.framework.cache.DictUtils;
import com.aidex.system.common.SysErrorCode;
import com.aidex.system.domain.SysDictData;
import com.aidex.system.mapper.SysDictDataMapper;
import com.aidex.system.service.SysDictDataService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Stream;

/**
 * 字典 业务层处理
 *
 * @author ruoyi
 */
@Service
public class SysDictDataServiceImpl extends BaseServiceImpl<SysDictDataMapper, SysDictData> implements SysDictDataService {

    /**
     * 根据字典类型和字典键值查询字典数据信息
     *
     * @param dictType  字典类型
     * @param dictValue 字典键值
     * @return 字典标签
     */
    @Override
    public String selectDictLabel(String dictType, String dictValue) {
        SysDictData sysDictData = new SysDictData();
        sysDictData.setDictType(dictType);
        sysDictData.setDictValue(dictValue);
        List<SysDictData> list = mapper.findList(sysDictData);
        if (!CollectionUtils.isEmpty(list)) {
            return list.get(0).getDictLabel();
        }
        return null;
    }

    /**
     * 批量删除字典数据信息
     *
     * @param ids 需要删除的字典数据ID
     * @return 结果
     */
    @Override
    @Transactional(readOnly = false)
    public int deleteDictDataByIds(String[] ids) {
        List<String> dictTypes = new ArrayList<String>();
        for (int i = 0; i < ids.length; i++) {
            SysDictData sysDictData = get(ids[i]);
            dictTypes.add(sysDictData.getDictType());
        }
        int row = mapper.deleteDictDataByIds(ids, BaseEntity.DEL_FLAG_DELETE);
        if (row > 0) {
            for (int j = 0; j < dictTypes.size(); j++) {
                DictUtils.clearDictCache(dictTypes.get(j));
            }
        }
        return row;
    }

    /**
     * 新增保存字典数据信息
     *
     * @param dictData 字典数据信息
     * @return 结果
     */
    @Override
    public boolean save(SysDictData dictData) {
        boolean result = super.save(dictData);
        if (result) {
            DictUtils.clearDictCache(dictData.getDictType());
        }
        return result;
    }

    /**
     * 校验字典类型称是否唯一
     *
     * @param sysDictData 字典类型
     * @return 结果
     */
    @Override
    public void checkDictDataValueUnique(SysDictData sysDictData) {
        SysDictData sysDictDataUnique = new SysDictData();
        sysDictDataUnique.setNotEqualId(sysDictData.getId());
        sysDictDataUnique.setDictValue(sysDictData.getDictValue());
        sysDictDataUnique.setDictType(sysDictData.getDictType());

        if (!CollectionUtils.isEmpty(mapper.findListWithUnique(sysDictDataUnique))) {
            throw new BizException(SysErrorCode.B_SYSDICDATA_DictValueAlreadyExist);
        }
    }

    /**
     * 获取最大排序
     *
     * @return
     */
    @Override
    public int findMaxSort(SysDictData sysDictData) {
        return NumberUtils.nextOrder(mapper.findMaxSort(sysDictData));
    }
}
