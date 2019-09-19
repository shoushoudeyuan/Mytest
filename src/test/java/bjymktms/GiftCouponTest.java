package bjymktms;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.alibaba.citrus.util.Assert;

import net.joystart.common.database.HandleDataSource;
import net.joystart.common.util.MessageResult;
import net.joystart.coupon.entity.Coupon;
import net.joystart.coupon.entity.CustomerCoupon;
import net.joystart.couponmanage.enums.CouponGiftModeEnum;
import net.joystart.couponmanage.enums.CustomerBehaviorEnum;
import net.joystart.couponmanage.remote.service.ICouponUseRemoteService;
import net.joystart.couponmanage.service.impl.CouponUseService;
import net.joystart.couponmanage.service.impl.GiftCouponContext;
import net.joystart.order.remote.service.IOrderRemoteService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:spring-config.xml") // 加载配置

public class GiftCouponTest {

	@Autowired
	GiftCouponContext factory;
	
	@Autowired
	private IOrderRemoteService orderService;
	
	@Autowired
	private ICouponUseRemoteService svcUseCoupon;
	
	@Resource
	ICouponUseRemoteService couponUseRemoteService;
	
	@Autowired
	CouponUseService couponUseService;
	
	@Before
	public void initial() throws Exception{
		HandleDataSource.putDataSource("fscs2");
	}
	
	@Test
	public void registerTest(){
		Map<CouponGiftModeEnum,MessageResult> ret = factory.giftCoupon(CustomerBehaviorEnum.用户注册成功, 11396, null,null);
		Assert.assertTrue(ret != null);
		MessageResult result = ret.get(CouponGiftModeEnum.注册用户赠);
		System.out.println(result.getCode());
		System.out.println(result.getMessage());
		System.out.println(result.getData());
		
	}
	
	@Test
	public void inviteTest(){
		Map<CouponGiftModeEnum,MessageResult> ret = factory.giftCoupon(CustomerBehaviorEnum.邀请码兑换, 11396, "56842594",null);
		Assert.assertTrue(ret != null);
		MessageResult result = ret.get(CouponGiftModeEnum.邀请好友赠);
		System.out.println(result.getCode());
		System.out.println(result.getMessage());
		System.out.println(result.getData());
	}
	
	@Test
	public void channelTest(){
		Map<CouponGiftModeEnum,MessageResult> ret = factory.giftCoupon(CustomerBehaviorEnum.渠道码兑换, 11396, "Q54088813",null);
		Assert.assertTrue(ret != null);
		MessageResult result = ret.get(CouponGiftModeEnum.渠道);
		System.out.println(result.getCode());
		System.out.println(result.getMessage());
		System.out.println(result.getData());
	}
	
	@Test
	public void promotionTest(){
		Map<CouponGiftModeEnum,MessageResult> ret = factory.giftCoupon(CustomerBehaviorEnum.推广码兑换, 11396, "Q13802029",null);
		Assert.assertTrue(ret != null);
		MessageResult result = ret.get(CouponGiftModeEnum.推广);
		System.out.println(result.getCode());
		System.out.println(result.getMessage());
		System.out.println(result.getData());
	}
	
	@Test
	public void orderCostTest(){
		Map<CouponGiftModeEnum,MessageResult> ret = factory.giftCoupon(CustomerBehaviorEnum.订单成功支付, 11396, null,52647);
		Assert.assertTrue(ret != null);
		MessageResult result = ret.get(CouponGiftModeEnum.订单满额赠);
		System.out.println(result.getCode());
		System.out.println(result.getMessage());
		System.out.println(result.getData());
	}
	
	@Test
	public void firstRentCarTest(){
		Map<CouponGiftModeEnum,MessageResult> ret = factory.giftCoupon(CustomerBehaviorEnum.用户成功还车, 11396, null,52647);
		Assert.assertTrue(ret != null);
		MessageResult result = ret.get(CouponGiftModeEnum.首次用车结单赠);
		System.out.println(result.getCode());
		System.out.println(result.getMessage());
		System.out.println(result.getData());
		
		ret = factory.giftCoupon(CustomerBehaviorEnum.订单成功支付, 11396, null,52647);
		Assert.assertTrue(ret != null);
		result = ret.get(CouponGiftModeEnum.首次用车结单赠);
		System.out.println(result.getCode());
		System.out.println(result.getMessage());
		System.out.println(result.getData());
	}
	
	@Test
	public void exchangeActivityTest(){
		Map<CouponGiftModeEnum,MessageResult> ret = factory.giftCoupon(CustomerBehaviorEnum.券包码兑换, 11396, "C142121",null);
		Assert.assertTrue(ret != null);
		MessageResult result = ret.get(CouponGiftModeEnum.券码兑换);
		System.out.println(result.getCode());
		System.out.println(result.getMessage());
		System.out.println(result.getData());
	}
	
	@Test
	public void firstEntMemberTest(){
		Map<CouponGiftModeEnum,MessageResult> ret = factory.giftCoupon(CustomerBehaviorEnum.成为企业会员, 11396, null,null);
		Assert.assertTrue(ret != null);
		MessageResult result = ret.get(CouponGiftModeEnum.券码兑换);
		System.out.println(result.getCode());
		System.out.println(result.getMessage());
		System.out.println(result.getData());
	}
	
	@Test
	public void getCustomerCouponListTest(){
		List<Coupon> lst = svcUseCoupon.CouponList(11325,52676);
		System.out.println(lst);
		
		lst = svcUseCoupon.historyCoupon(11403, 10, 0);
		System.out.println(lst);
	}
	
	@Test
	public void TimerSendCouponTest(){
		Map<CouponGiftModeEnum,MessageResult> ret = factory.giftCoupon(CustomerBehaviorEnum.系统定时赠送, 107, null,null);
		Assert.assertTrue(ret != null);
		MessageResult result = ret.get(CouponGiftModeEnum.券码兑换);
		System.out.println(result.getCode());
		System.out.println(result.getMessage());
		System.out.println(result.getData());
	}

	
	@Test
	public void useCouponTest(){
		Coupon coupon = new Coupon();
		coupon.setId(150008);
		couponUseService.setCustomerCouponIsUsed(coupon);
		System.out.println(coupon);
	}
}
