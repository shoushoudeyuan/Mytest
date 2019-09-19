package net.joystart.city.dao;

import java.util.List;

import net.joystart.city.entity.Area;

public interface AreaMapper {
    int deleteByPrimaryKey(Long id);

    int insert(Area record);

    int insertSelective(Area record);

    Area selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(Area record);

    int updateByPrimaryKeyWithBLOBs(Area record);

    int updateByPrimaryKey(Area record);
    
    List<Area> getProvince() ;
    List<Area> getCityOrCounty(Long id) ;
}