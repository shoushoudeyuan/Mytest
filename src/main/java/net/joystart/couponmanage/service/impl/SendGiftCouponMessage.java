package net.joystart.couponmanage.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;

import net.joystart.common.database.HandleDataSource;
import net.joystart.common.entity.PayConfig;
import net.joystart.common.service.IPayConfigService;
import net.joystart.common.util.ConstantUtil;
import net.joystart.common.util.PostMsgHttpContent;
import net.joystart.couponmanage.entity.CouponPackageItem;
import net.joystart.couponmanage.enums.CouponGiftModeEnum;
import net.joystart.couponmanage.service.ICouponPackageService;
import net.joystart.customer.entity.Customer;
import net.joystart.customer.remote.service.ICustomerRemoteService;
import net.joystart.customer.remote.service.IMessageRemoteService;
import net.joystart.setting.entity.BaseMessageTemplate;
import net.joystart.setting.remote.service.IBaseMessageTemplateRemoteService;

@Component
public class SendGiftCouponMessage {

	@Autowired
	protected ICouponPackageService svcCouponPackage;
	
	@Autowired
	private ICustomerRemoteService customerRemoteService;
	
	@Resource 
    IBaseMessageTemplateRemoteService baseMessageTemplateRemoteService;
	
	@Resource
    IPayConfigService payConfigService;
	
	@Resource
	IMessageRemoteService messageRemoteService;
	
	@Async
	public void sendMessage(CouponGiftModeEnum mode,Integer packageId,Integer coustomerId,String dataSource,String hostName){
		//自动发券 true,手动发券fasle;
		HandleDataSource.putDataSource(dataSource);
		HandleDataSource.putHostName(hostName);
		BaseMessageTemplate msg = null;
		if(CouponGiftModeEnum.系统录入 == mode){
			msg = baseMessageTemplateRemoteService.selectTitleAndContentByIdentification(ConstantUtil.M_MANUAL_COUPONS);
		}else{
			msg = baseMessageTemplateRemoteService.selectTitleAndContentByIdentification(ConstantUtil.M_SYSTEM_COUPONS);
		}
		Customer customer = this.customerRemoteService.selectByPrimaryKey(coustomerId);
		if(msg!=null&&customer!=null&&msg.getMessageType()!=null){
			List<CouponPackageItem> lstCouponPackageItem = svcCouponPackage.selectCouponPackageItem(packageId);
			if(lstCouponPackageItem!=null){
				StringBuffer sb = new StringBuffer();
				for(CouponPackageItem item : lstCouponPackageItem){
					String coupnName = item.getCouponName();
					Integer couponCount = item.getCouponCount();
					sb.append(couponCount+"张").append(coupnName).append("、");
				}
				sb.deleteCharAt(sb.length() - 1);
				String content = msg.getContent().replaceAll("【couponInfo】", sb.toString());
				if(msg.getMessageType().indexOf(ConstantUtil.MESSAGETYPE_SMS)!=-1){
					PayConfig payConfig = payConfigService.seleConfigByHost(hostName);
					PostMsgHttpContent.sendMessage(customer.getMobile(),content,payConfig.getSmstaskid());
				}
				HandleDataSource.putDataSource(dataSource);
				if(msg.getMessageType().indexOf(ConstantUtil.MESSAGETYPE_SYS)!=-1){
					messageRemoteService.sendSysMessage(msg.getTitle(), content, customer.getId());
				}
			}
		}
		
	}
}
