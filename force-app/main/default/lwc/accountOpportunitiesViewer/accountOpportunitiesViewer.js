import { LightningElement, api, wire, track } from 'lwc';
import getOpportunities from '@salesforce/apex/AccountOpportunitiesController.getOpportunities';
import { refreshApex } from '@salesforce/apex'; // Import de refreshApex pour rafraîchir la liste

export default class AccountOpportunitiesViewer extends LightningElement {
    @api recordId;
    @track opportunities;
    @track error; // Initialiser error sans valeur {} 
    wiredOpportunitiesResult; //  pour stocker le résultat du DECorateur wire

    columns = [
        { label: 'Nom Opportunité', fieldName: 'Name', type: 'text' },
        { label: 'Montant', fieldName: 'Amount', type: 'currency' },
        { label: 'Date de Clôture', fieldName: 'CloseDate', type: 'date' },
        { label: 'Phase', fieldName: 'StageName', type: 'text' }
    ];

    @wire(getOpportunities, { accountId: '$recordId' })//  $recordId et stockage du résultat wire

    wiredOpportunities(result) {
        this.wiredOpportunitiesResult = result;
        const { data, error } = result;
        if (data) {
            this.opportunities = data;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.opportunities = undefined;
        }
    }

    // AjoutER la méthode handleRafraichir qui etait absente dansLe
    handleRafraichir() {
        if (this.wiredOpportunitiesResult) {
            refreshApex(this.wiredOpportunitiesResult);
        }
    }
}
