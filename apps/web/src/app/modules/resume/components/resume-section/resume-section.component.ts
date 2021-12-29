import {animate, group, query, stagger, state, style, transition, trigger} from '@angular/animations';
import {ChangeDetectionStrategy, Component, Input} from '@angular/core';
import {ResumeSectionDetail} from '../../models';

@Component({
    selector: 'jf-resume-section',
    templateUrl: './resume-section.component.html',
    styleUrls: ['./resume-section.component.scss'],
    changeDetection: ChangeDetectionStrategy.OnPush,
    animations: [
        trigger('reveal', [
            state('false', style({
                opacity: 0
            })),
            transition('* => true', [
                // hide pills initially
                query('jf-pill', [style({opacity: 0})], {optional: true}),
                group([
                    animate('500ms'),
                    query('ul.list li', [
                        style({
                            transform: 'translateX(-16px)',
                            opacity: 0
                        }),
                        stagger('250ms', [
                            animate('250ms')
                        ])
                    ])
                ]),
                query('.resume-section-item jf-pill', [
                    style({
                        opacity: 0
                    }),
                    stagger('100ms', [
                        animate('100ms')
                    ])
                ], {optional: true})
            ])
        ])

    ]
})
export class ResumeSectionComponent {
    @Input()
    model!: ResumeSectionDetail;
}
