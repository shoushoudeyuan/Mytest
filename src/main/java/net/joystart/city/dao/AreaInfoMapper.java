package net.joystart.city.dao;

import net.joystart.city.entity.AreaInfo;

public interface AreaInfoMapper {
    int deleteByPrimaryKey(Long id);

    int insert(AreaInfo record);

    int insertSelective(AreaInfo record);

    AreaInfo selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(AreaInfo record);

    int updateByPrimaryKeyWithBLOBs(AreaInfo record);

    int updateByPrimaryKey(AreaInfo record);
}