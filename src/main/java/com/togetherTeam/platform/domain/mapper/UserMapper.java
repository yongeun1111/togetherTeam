package com.togetherTeam.platform.domain.mapper;

import java.util.List;

import com.togetherTeam.platform.domain.entity.User;


public interface UserMapper {
    public User save(User user);
    public List<User> all();

}
