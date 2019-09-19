package net.joystart.customerservice.dao;

import java.util.List;
import java.util.Map;

import net.joystart.customerservice.entity.AnswerQuestion;

public interface AnswerQuestionMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(AnswerQuestion record);

    int insertSelective(AnswerQuestion record);

    AnswerQuestion selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(AnswerQuestion record);

    int updateByPrimaryKey(AnswerQuestion record);

	List<AnswerQuestion> getAnswerQuestions(Map<String, Object> params);

	int getAnswerQuestionCount(Map<String, Object> params);

}