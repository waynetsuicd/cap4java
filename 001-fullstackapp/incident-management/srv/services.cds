using { sap.capire.incidents as my } from '../db/schema';

service ProcessorService {
    entity Incidents as projection on my.Incidents;
    @readonly
    entity Customers as projection on my.Customers;
}

annotate ProcessorService with @(requires:'support');
annotate ProcessorService.Incidents with @odata.draft.enabled;

service AdminService{
    entity Customers as projection on my.Customers;
    entity Incidents as projection on my.Incidents;
}

annotate AdminService with @(requires:'admin');
