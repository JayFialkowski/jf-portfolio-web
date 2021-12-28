import {Component, Input} from '@angular/core';
import {PillVariant} from '@web-portfolio/ui';

@Component({
    selector: 'jf-pill',
    templateUrl: './pill.component.html',
    styleUrls: ['./pill.component.scss']
})

export class PillComponent {
    @Input()
    variant: PillVariant = 'primary';
}
