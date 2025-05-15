using {sap.capire.bookstore as db} from '../db/schema';

service BookService {

    @readonly
    entity Books   as
        projection on db.Books {
            *,
            category as genre
        }
        excluding {
            category,
            createdBy,
            createdAt
        };

    @readonly
    entity Autores as projection on db.Authors;
}

service OrdersService {
    @(restrict: [
        {
            grant: '*',
            to   : 'Administrators'
        },
        {
            grant: '*',
            where: 'createdBy = $user'
        }
    ])
    entity Orders     as projection on db.Orders;

    @(restrict: [
        {
            grant: '*',
            to   : 'Administrators'
        },
        {
            grant: '*',
            where: 'parent.createdBy = $user'
        }
    ])
    entity OrderItems as projection on db.OrderItems;
}

using {AdminService} from '@sap/capire-products';

extend service AdminService with {
    entity Authors as projection on db.Authors;
};

annotate AdminService @(requires: 'Administrators');
