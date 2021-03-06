package cn.com.tsjx.common.constants.enums;

public enum UserEnum {

	user_message_0("1", "管理员", "user_type"),
	user_message_1("2", "普通会员", "user_type"),

	/*销售方式(类型)*/
	user_type_admin("0", "超级管理员", "user_type"),
	user_type_master("1", "管理员", "user_type"),
	user_type_member("2", "普通会员", "user_type"),
	user_type_company("3", "企业管理员", "user_type"),
    
	/**
	 * 营业范围
	 */
    user_scope_gc("1","工程机械","user_scope"),
    user_scope_ny("2","农业机械","user_scope"),
    user_scope_ks("3","矿山机械","user_scope"),
    user_scope_ly("4","林业机械","user_scope"),
    user_scope_gccl("5","运输车辆","user_scope"),
	
	/**
	 * 经营性质
	 */
	user_business_nature_scs("1","生产商","user_business_nature"),
	user_business_nature_dls("2","代理商","user_business_nature"),
	user_business_nature_mj1("3","买家","user_business_nature"),
	user_business_nature_mj2("4","卖家","user_business_nature"),
	user_business_nature_mmmy("5","买卖贸易","user_business_nature"),
	user_business_nature_zj("6","中介","user_business_nature"),
	user_business_nature_wx("7","维修","user_business_nature"),
	user_business_nature_pjs("8","配件商","user_business_nature"),
	user_business_nature_dy("9","抵押","user_business_nature");

	private final String code;
	private final String description;
	private final String type;

	private UserEnum(String code, String description, String type) {
		this.code = code;
		this.description = description;
		this.type = type;
	}

	public String code() {
		return this.code;
	}

	public String description() {
		return this.description;
	}

	public static String getDiscribeByCode(String code) {
		String description = null;
		for (UserEnum ie : UserEnum.values()) {
			if (ie.code.equals(code)) {
				description = ie.description;
			}
		}
		return description;
	}

	public static UserEnum[] getEnumsByType(String type) {
		UserEnum[] enums = new UserEnum[] {};
		int i = 0;
		for (UserEnum ie : UserEnum.values()) {
			if (ie.type.equals(type)) {
				enums[i++] = ie;
			}
		}
		return enums;
	}

	public static void main(String[] args) {
		UserEnum[] enums = UserEnum.getEnumsByType("procedures");
		System.out.println("enums length is :" + enums.length);
	}

}
