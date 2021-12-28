import {ChangeDetectionStrategy, Component, Input} from '@angular/core';
import {ResumeSectionDetail} from '../../models';

@Component({
    selector: 'jf-resume-section',
    templateUrl: './resume-section.component.html',
    styleUrls: ['./resume-section.component.scss'],
    changeDetection: ChangeDetectionStrategy.OnPush
})
export class ResumeSectionComponent {
    @Input()
    model!: ResumeSectionDetail;
}
