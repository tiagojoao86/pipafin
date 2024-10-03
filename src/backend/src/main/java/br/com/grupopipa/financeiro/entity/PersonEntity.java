package br.com.grupopipa.financeiro.entity;

import br.com.grupopipa.financeiro.dto.person.PersonDTO;
import br.com.grupopipa.financeiro.entity.base.BaseEntity;
import br.com.grupopipa.financeiro.enumeration.DocumentTypeEnum;
import br.com.grupopipa.financeiro.enumeration.PersonTypeEnum;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity(name = "person")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class PersonEntity extends BaseEntity<PersonDTO> {

    @Column(nullable = false)
    private String name;

    @Column(nullable = false)
    private String fantasyName;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private PersonTypeEnum personType;

    @Column(nullable = false)
    private String document;

    @Column(nullable = false)
    @Enumerated(EnumType.STRING)
    private DocumentTypeEnum documentType;

    @Column(nullable = false)
    private String addressNumber;

    @Column(nullable = false)
    private String addressStreet;

    @Column(nullable = false)
    private String addressNeighborhood;

    @Column(nullable = false)
    private String addressCity;

    @Column(nullable = false)
    private String addressState;

    @Column(nullable = false)
    private String addressPostalCode;

    @Column(nullable = false)
    private String phone1;

    private String phone2;

    @Override
    public void fillFromDTO(PersonDTO item) {
        this.setId(item.getId());
        this.name = item.getName();
        this.fantasyName = item.getFantasyName();
        this.personType = item.getPersonType();
        this.document = item.getDocument();
        this.documentType = item.getDocumentType();
        this.addressNumber = item.getAddressNumber();
        this.addressStreet = item.getAddressStreet();
        this.addressNeighborhood = item.getAddressNeighborhood();
        this.addressCity = item.getAddressCity();
        this.addressState = item.getAddressState();
        this.addressPostalCode = item.getAddressPostalCode();
        this.phone1 = item.getPhone1();
        this.phone2 = item.getPhone2();
    }
}
