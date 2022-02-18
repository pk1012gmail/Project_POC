import { LightningElement, track, wire } from 'lwc';
import authenticateUser from '@salesforce/apex/Authenticate2Controller.authenticateUser';

export default class loginCmp extends LightningElement {
    @track name;
    @track passwd;
    @track region;
    @track str;
    @track error;
    submit(event)
    {
        console.log(event.target.label);
        var inp=this.template.querySelectorAll(".inp");
        inp.forEach(function(element){
            if(element.name=="inputName")
                this.name=element.value;

            else if(element.name=="inputPassword")
                this.passwd=element.value;

            else if(element.name=="inputRegion")
            this.region=element.value;
        },this);

        authenticateUser()
            .then(result => {
                this.str = result;
                console.log(result);
            })
            .catch(error => {
                this.error = error;
            });
    }
}