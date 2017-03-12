package com.oaec.housecrm.dao;

import java.util.List;
import java.util.Map;

/**
 * Created by Kevin on 2017/3/12.
 */
public interface CustomerTypeDao {

    /**
     * 查询当前所有的Type
     * @return
     */
    List<Map<String,Object>> queryAll();

    /**
     * 修改type名称
     * @param parameters
     * @return
     */
    int update(Map<String,Object> parameters);

    /**
     * 删除
     * @param type_id
     * @return
     */
    int delete(String type_id);

    /**
     * 添加
     * @param type_name
     * @return
     */
    int add(String type_name);
}
