package br.com.grupopipa.financeiro.dto;

import br.com.grupopipa.financeiro.entity.AccountEntity;

import java.util.UUID;

public class AccountDTO implements DTO<AccountEntity>{
    @Override
    public UUID getId() {
        return null;
    }

    @Override
    public void fillFromEntity(AccountEntity entity) {

    }
}
