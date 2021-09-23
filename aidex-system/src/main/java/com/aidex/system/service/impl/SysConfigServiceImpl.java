package com.aidex.system.service.impl;

import com.aidex.common.constant.UserConstants;
import com.aidex.common.core.domain.BaseEntity;
import com.aidex.common.core.service.BaseServiceImpl;
import com.aidex.common.exception.BizException;
import com.aidex.common.exception.CustomException;
import com.aidex.common.utils.StringUtils;
import com.aidex.framework.cache.ConfigUtils;
import com.aidex.system.common.SysErrorCode;
import com.aidex.system.domain.SysConfig;
import com.aidex.system.mapper.SysConfigMapper;
import com.aidex.system.service.SysConfigService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import java.util.List;

/**
 * 参数配置 服务层实现
 * 
 * @author ruoyi
 */
@Service
public class SysConfigServiceImpl extends BaseServiceImpl<SysConfigMapper, SysConfig> implements SysConfigService
{
    /**
     * 根据键名查询参数配置信息
     *
     * @param configKey 参数key
     * @return 参数键值
     */
    @Override
    public String selectConfigByKey(String configKey)
    {
        SysConfig configCache = ConfigUtils.getConfigByKey(ConfigUtils.getCacheKey(configKey));
        if (configCache != null)
        {
            return configCache.getConfigValue();
        }
        SysConfig config = new SysConfig();
        config.setConfigKey(configKey);
        List<SysConfig> retConfigList = findList(config);

        if (retConfigList != null && retConfigList.size() > 0)
        {
            SysConfig retConfig = retConfigList.get(0);
            ConfigUtils.setConfigCache(retConfig);
            return retConfig.getConfigValue();
        }
        return StringUtils.EMPTY;
    }

    /**
     * 保存参数信息
     * @param sysConfig
     * @return
     */
    @Override
    public boolean save(SysConfig sysConfig) {
        checkConfigKeyUnique(sysConfig);
        boolean result = super.save(sysConfig);
        if(result){
            ConfigUtils.clearConfigCache(sysConfig.getConfigKey());
            ConfigUtils.setConfigCache(sysConfig);
        }
        return result;
    }

    /**
     * 批量删除参数信息
     *
     * @param configIds 需要删除的参数ID
     * @return 结果
     */
    @Override
    @Transactional(readOnly = false)
    public int deleteConfigByIds(String[] configIds)
    {
        for (String configId : configIds)
        {
            SysConfig config = super.get(configId);
            if (StringUtils.equals(UserConstants.YES, config.getConfigType()))
            {
                throw new CustomException(String.format("内置参数【%1$s】不能删除 ", config.getConfigKey()));
            }
        }
        int count = mapper.deleteConfigByIds(configIds, BaseEntity.DEL_FLAG_DELETE);
        if (count > 0)
        {
            ConfigUtils.clearConfigCache();
        }
        return count;
    }

    @Override
    public void clearCache() {
        ConfigUtils.clearConfigCache();
    }


    /**
     * 校验参数键名是否唯一
     *
     * @param config 参数配置信息
     * @return 结果
     */
    @Override
    public void checkConfigKeyUnique(SysConfig config)
    {
        SysConfig sysConfigUnique = new SysConfig();
        sysConfigUnique.setNotEqualId(config.getId());
        sysConfigUnique.setConfigKey(config.getConfigKey());
        if (!CollectionUtils.isEmpty(mapper.findListWithUnique(sysConfigUnique))) {
            throw new BizException(SysErrorCode.B_SYSCONFIG_ConfigKeyAlreadyExist);
        }
    }

}
