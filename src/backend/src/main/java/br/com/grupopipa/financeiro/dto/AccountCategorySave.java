package br.com.grupopipa.financeiro.dto;

import br.com.grupopipa.financeiro.enumeration.AccountTypeEnum;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class AccountCategorySave {

    private UUID id;
    private String description;
    private AccountTypeEnum type;

}
