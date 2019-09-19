package net.joystart.couponmanage.enums;

/**
 * 优惠券使用状态枚举类
 * @author zm.mu
 *
 */
public enum CouponUsedEnum {
	
	/**
	 * 未使用
	 */
	NOTUSED(1),
	
	/**
	 * 已使用
	 */
	USED(2),
	
	/**
	 * 已过期
	 */
	EXPIRED(3);
	
	private CouponUsedEnum(int code) {
		this.code=code;
	}
	private int code;

	public int getCode() {
		return code;
	}
	
	public static String valueOfCode(int code){
		if (code == 1) {
			return "未使用";
		}else if (code == 2) {
			return "已使用";
		}else if (code == 3){
			return "已过期";
		}
		return "";
	}
	
}
