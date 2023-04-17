package com.togetherTeam.platform.mapper;

import java.util.List;

import com.togetherTeam.platform.entity.User;


public interface UserMapper {
    public User save(User user);
    public List<User> all();

}
