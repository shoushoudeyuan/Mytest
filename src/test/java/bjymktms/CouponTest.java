package bjymktms;

import static org.junit.Assert.assertEquals;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.util.Assert;

import net.joystart.common.database.HandleDataSource;
import net.joystart.couponmanage.entity.CouponUseConfig;
import net.joystart.couponmanage.enums.CouponTypeEnum;
import net.joystart.couponmanage.service.ICouponUseConfigService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:spring-config.xml") // 加载配置
public class CouponTest {

	@Autowired
	private ICouponUseConfigService svcRule;
	
	@Before
	public void initial() throws Exception{
		HandleDataSource.putDataSource("fscs2");
	}
	
	@Test
	public void insertTest(){
		CouponUseConfig config = new CouponUseConfig();
		config.setConfigName("test");
		config.setCouponType(CouponTypeEnum.DEDUCTION.getValue());
		//config.setDiscountPercent(50);
		//config.setMaxDeductionMoney(10);
		config.setCouponMoney(10.0);
		config.setValidateDay(3);
		config.setUseCityId("1,2,3");
		config.setUseWeekDay("1,2,3");
		config.setUseLowerTime("08:00");
		config.setUseLowerTime("20:00");
		config.setBaseOrderMoney(100.00);
		config.setUseVehicleModeId("1,2,3");
		config.setAppDiscription("apptest");
		config.setIsValidate(1);
		
		boolean ret = svcRule.saveCouponUseConfig(config);
		Assert.isTrue(ret);
	}
	
	@Test
	public void updateState(){
		boolean ret = svcRule.disableCouponUseConfig(1);
		Assert.isTrue(ret);
	}
	
	
	@Test
	public void deleteCouponConfig(){
		List<Integer> ids = new ArrayList<>();
		ids.add(1);
		ids.add(2);
		int ret = svcRule.deleteCouponUseConfig(ids);
		Assert.isTrue(ret == 2);
	}
	
	@Test
	public void selectCouponConfig(){
//		List<CouponRuleConfig> lst = svcRule.selectCouponRuleConfig(1, 1, null, null, null);
		int count = svcRule.selectCouponUseConfigCount(null,null,null);
		System.out.println(count);
	}
	
}
