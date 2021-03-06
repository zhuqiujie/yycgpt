package yycgpt.base.service;

import java.util.List;

import yycgpt.base.pojo.po.Sysuser;
import yycgpt.base.pojo.po.Usergys;
import yycgpt.base.pojo.po.Useryy;
import yycgpt.base.pojo.vo.ActiveUser;
import yycgpt.base.pojo.vo.SysuserCustom;
import yycgpt.base.pojo.vo.SysuserQueryVo;

public interface UserService {
	
	//用户认证
	public ActiveUser checkUserInfo(String userId, String pwd) throws Exception;
	//根据条件查询用户列表
	public  List<SysuserCustom> findSysuserList(SysuserQueryVo sysuserQueryVo)throws Exception;
	//根据条件查询列表的总数
	public  int findSysuserCount(SysuserQueryVo sysuserQueryVo)throws Exception;
	//添加用户
	public void insertSysuser(SysuserCustom sysuserCustom)throws Exception;
	//注册用户
	public SysuserCustom registerSysuser(SysuserCustom sysuserCustom)throws Exception;
	//注册成功页面跳转
	public void registerSuccess(String activecode)throws Exception;
	//根据激活码获取用户信息
	/**
	 * vchart1作为激活码字段
	 * @param activecode:激活码是唯一的
	 * @return
	 * @throws Exception
	 */
	public Sysuser findUserByVachrt1(String activecode)throws Exception;
	//根据用户帐号查询用户
	public Sysuser findSysuserByUserId(String userid)throws Exception;
	//卫生室、医院
	public Useryy findUserYyByMc(String mc)throws Exception;
	//供应商
	public Usergys findUserGysByMc(String mc)throws Exception;
	//删除用户
	public void deleteSysuser(String userId)throws Exception;
	/**
	* @Title: updateSysuser  
	* @Description: TODO 
	* @param userId 用户的id
	* @param sysuserCustom 表单提交的数据
	* @throws Exception
	* @return void    
	* @user zhuqiujie
	* @date  2017年11月27日上午11:20:12
	 */
	//修改用户
	public void updateSysuser(String userId,SysuserCustom sysuserCustom)throws Exception;
	/**
	 * 
	* @Title: findSysuserById  
	* @Description: 根据用户id获取用户信息
	* @param id
	* @throws Exception
	* @return SysuserCustom    
	* @user zhuqiujie
	* @date  2017年11月27日下午4:23:55
	 */
	public SysuserCustom findSysuserById(String id)throws Exception;
	//根据用户userid修改用户密码
	public void updateSysuserPwdByUserId(String userId,SysuserCustom sysuserCustom)throws Exception;
}
