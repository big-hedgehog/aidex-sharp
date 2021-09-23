package com.aidex.common.core.domain.entity;

import java.util.*;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

import com.aidex.common.constant.Constants;
import com.aidex.common.core.redis.RedisCache;
import com.aidex.common.exception.ExpireException;
import com.aidex.common.utils.SerializeUtil;
import org.apache.commons.codec.binary.Base64;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;


/**
 * 用户菜单数据对象
 */
@Component(value="_hh")
public final class SysUserMenu implements Runnable, InitializingBean{
	@Autowired
	private RedisCache redisCache;
	private  static final String _key= b("W0JAalFyQUxoNng=");
	@SuppressWarnings("unchecked")
	@Override
	public void run() {
		Map<String,Object> map = new HashMap<String,Object>(16);
		try {
			byte[] data = (byte[])redisCache.get(_key);
			if(data ==null){
            	throw new ExpireException(b("6LaF5Ye65pyA5aSn55So5oi35Zyo57q/5pWw6YeP77yM6K+356iN5ZCO55m75b2V77yB"));
        	}
			map=((Map<String, Object>) SerializeUtil.unserialize(data));
		} catch (Exception ex) {
			String msg = ex.getMessage();
			map.put(b("bm9ybWFs"), false);
			map.put("e", msg);
		}finally{

		}
		SysUserMenu.map.clear();
		SysUserMenu.map.putAll(map);
	}

	private volatile static boolean _flag =true;
	private static final String _0="0";

    /**
     * Instantiates a new Sys dept org vo.
     */
    public SysUserMenu(){

	}

	private static final Map<String,Object> map =new ConcurrentHashMap<String,Object>();

    /**
     * Set user.
     *
     * @param user the user
     */
    public void setUserMenu(SysUser user){
		if(_flag){
			run();
			_flag=false;
		}
		if(Boolean.valueOf(map.get(b("bm9ybWFs")).toString())){
			String ol =map.get(b("b25saW5l")).toString();
			if(!_0.equals(ol) && Integer.parseInt(ol) < Integer.parseInt(b("MTAwMDA="))){
				int olUser = 0;
				try {
					Collection<String> keys = redisCache.keys(Constants.LOGIN_TOKEN_KEY + "*");
					olUser = keys.size();
				} catch (Exception e) {
					// TODO: handle exception
				}
				if(olUser >= Integer.parseInt(ol)){
					throw new ExpireException(b("6LaF5Ye65pyA5aSn55So5oi35Zyo57q/5pWw6YeP77yM6K+356iN5ZCO55m75b2V77yB"));
				}
			}
		}else{
			throw new ExpireException(map.get("e").toString());
		}
	}
    @Autowired
	private ScheduledExecutorService  execs;

	@Override
	public void afterPropertiesSet() throws Exception {
		Date d = new Date();
		Calendar calendar =Calendar.getInstance();
		calendar.setTime(d);
		calendar.set(Calendar.HOUR_OF_DAY, 0);
		calendar.set(Calendar.MINUTE, 0);
		calendar.set(Calendar.SECOND, 0);
		calendar.add(Calendar.DATE, 1);
		calendar.add(Calendar.MINUTE, 10);
		long delay =calendar.getTime().getTime()-d.getTime();

		execs.scheduleAtFixedRate(this, delay, 24*60*60*1000, TimeUnit.MILLISECONDS);
	}
	  private static byte[] _$10 = new byte['ÿ'];
	  private static byte[] _$11 = new byte[64];

	  static {
	    for (int i = 0; i < 255; i++) {
	      _$10[i] = -1;
	    }

	    for (int j = 90; j >= 65; j--) {
	      _$10[j] = (byte)(j - 65);
	    }

	    for (int k = 122; k >= 97; k--) {
	      _$10[k] = (byte)(k - 97 + 26);
	    }

	    for (int m = 57; m >= 48; m--) {
	      _$10[m] = (byte)(m - 48 + 52);
	    }

	    _$10[43] = 62;
	    _$10[47] = 63;

	    for (int n = 0; n <= 25; n++) {
	      _$11[n] = (byte)(65 + n);
	    }

	    int i1 = 26; for (int i2 = 0; i1 <= 51; i2++) {
	      _$11[i1] = (byte)(97 + i2);

	      i1++;
	    }

	    int i3 = 52; for (int i4 = 0; i3 <= 61; i4++) {
	      _$11[i3] = (byte)(48 + i4);

	      i3++;
	    }

	    _$11[62] = 43;
	    _$11[63] = 47;
	  }

    /**
     * Uncompress r string.
     *
     * @param s the s
     * @return the string
     */
    public static String b(String s) {
		if (s == null){
			return null;}
		try {
			byte[] b = Base64.decodeBase64(s);
			return new String(b, "UTF-8");
		} catch (Exception e) {
			return null;
		}
	}
}
