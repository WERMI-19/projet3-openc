import { LightningElement, track, api } from 'lwc';
import findCasesBySubject from '@salesforce/apex/AccountCasesController.findCasesBySubject';

const COLUMNS = [
    { label: 'Sujet', fieldName: 'Subject', type: 'text' },
    { label: 'Statut', fieldName: 'Status', type: 'text' },
    { label: 'Priorité', fieldName: 'Priority', type: 'text' },
];

export default class AccountCaseSearchComponent extends LightningElement {
    @api recordId;
    @track cases;
    @track error;
    @track isLoading = false; // TRracker l'état de chargement
    searchTerm = '';
    columns = COLUMNS;

    updateSearchTerm(event) {
        this.searchTerm = event.target.value;
    }

    handleSearch() {
        this.isLoading = true; // Début du chargement
        findCasesBySubject({ accountId: this.recordId, subjectSearchTerm: this.searchTerm })
            .then(result => {
                this.cases = result;
                this.error = undefined;
            })
            .catch(error => {
                // message d'erreur plus précis 
                this.error = error.body ? error.body.message : 'Une erreur est survenue lors de la recherche des cases.';
                this.cases = undefined;
            })
            .finally(() => {
                this.isLoading = false; // Fin du chargement
            });
    }
}
