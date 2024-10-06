package br.com.grupopipa.financeiro.dto.person;

import br.com.grupopipa.financeiro.dto.data.FilterDTO;
import br.com.grupopipa.financeiro.enumeration.PersonTypeEnum;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class PersonFilterDTO extends FilterDTO {
    private String name;
    private PersonTypeEnum[] types;
    private String document;
    private String phone;
    private String address;

}
