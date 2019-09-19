package net.joystart.couponmanage.enums;

public enum CouponTypeEnum {

	DISCOUNT(1),DEDUCTION(2);
	
	private int value;
	
	private CouponTypeEnum(int value){
		this.value=value;
	}
	
	public int getValue(){
		return this.value;
	}
	
	public static String valueOfCode(int code){
		String value = "";
		switch (code) {
		case 1:
			value="折扣券";
			break;
		case 2:
			value="减免券";
			break;

		default:
			break;
		}
		return value;
	}
}
