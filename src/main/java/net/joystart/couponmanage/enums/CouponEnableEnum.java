package net.joystart.couponmanage.enums;

/**
 * 启用禁用枚举类
 * @author zm.mu
 *
 */
public enum CouponEnableEnum {
	
	/**
	 * 启用
	 */
	ENABLE(1),
	
	/**
	 * 禁用
	 */
	DISABLE(2);
	
	private CouponEnableEnum(int code) {
		this.code = code;
	}
	
	private int code;

	public int getCode() {
		return code;
	}

	public void setCode(int code) {
		this.code = code;
	}
	
}
