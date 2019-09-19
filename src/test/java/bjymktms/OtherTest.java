package bjymktms;

import java.util.ArrayList;
import java.util.List;

import org.junit.Test;

import net.joystart.couponmanage.entity.CustomerCouponNew;

public class OtherTest {

	@Test
	public void SubListTest(){
		int from = 0;
		int to = 0;
		int page = 0;
		int pageSize = 5;
		List<Integer> lstCoupon = new ArrayList<>();
		for(int i = 1 ; i <= 5;i++ ){
			lstCoupon.add(i);
		}
		List<Integer> lstSub = new ArrayList<>();
		int retCount = 0;
		
		do{
			page += 1;
			from = (page - 1) * pageSize;
			to = page * pageSize;
			if(to > lstCoupon.size())
				to = lstCoupon.size();
			lstSub = lstCoupon.subList(from, to);
			System.out.println(lstSub);
		}while(lstSub != null && lstSub.size() > 0 && to < lstCoupon.size());
		
		System.out.println(retCount);
	}
}
