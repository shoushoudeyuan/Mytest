package net.joystart.setting.remote.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.transaction.annotation.Transactional;

import com.alibaba.dubbo.config.annotation.Service;

import net.joystart.setting.dao.ScoreRuleSetMapper;
import net.joystart.setting.entity.ScoreRuleSet;
import net.joystart.setting.remote.service.IScoreRuleSetRemoteService;

@Service(timeout = 60000, retries = 0,interfaceClass=IScoreRuleSetRemoteService.class)
@Transactional
public class ScoreRuleSetRemoteServiceImpl implements IScoreRuleSetRemoteService {

	@Resource
	ScoreRuleSetMapper scoreRuleSetMapper;

	@Override
	public int deleteByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return scoreRuleSetMapper.deleteByPrimaryKey(id);
	}

	@Override
	public int insert(ScoreRuleSet record) {
		// TODO Auto-generated method stub
		return scoreRuleSetMapper.insert(record);
	}

	@Override
	public int insertSelective(ScoreRuleSet record) {
		// TODO Auto-generated method stub
		return scoreRuleSetMapper.insertSelective(record);
	}

	@Override
	public ScoreRuleSet selectByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return scoreRuleSetMapper.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(ScoreRuleSet record) {
		// TODO Auto-generated method stub
		return scoreRuleSetMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(ScoreRuleSet record) {
		// TODO Auto-generated method stub
		return scoreRuleSetMapper.updateByPrimaryKey(record);
	}

	@Override
	public List<ScoreRuleSet> selectAll(Map params) {
		// TODO Auto-generated method stub
		return scoreRuleSetMapper.selectAll(params);
	}

	@Override
	public int selectCount(Map params) {
		return scoreRuleSetMapper.selectCount(params);
	}

	@Override
	public ScoreRuleSet selectBySengType(Integer sendType) {
		return scoreRuleSetMapper.selectBySengType(sendType);
	}
	
}
