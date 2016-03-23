package cn.com.tsjx.infomation.dao;

import java.util.List;

import cn.com.tsjx.common.dao.BaseDao;
import cn.com.tsjx.infomation.entity.Infomation;
import cn.com.tsjx.user.entity.User;

public interface InfomationDao extends BaseDao<Infomation, Long> {

    public List<Infomation> getInfomationsByParam(User user, Infomation infomation);
}