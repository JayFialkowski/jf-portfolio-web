import {NgModule} from '@angular/core';
import {RouterModule, Routes} from '@angular/router';
import {ResumeComponent} from './components/resume/resume.component';
import {ResumeSectionComponent} from './components/resume-section/resume-section.component';
import {CommonModule} from '@angular/common';
import {ObserveVisibilityDirectiveModule, PillModule} from '@web-portfolio/ui';
import {BrowserAnimationsModule} from '@angular/platform-browser/animations';

const routes: Routes = [
    {
        path: '',
        pathMatch: 'full',
        component: ResumeComponent
    }
];

@NgModule({
    declarations: [
        // components
        ResumeComponent,
        ResumeSectionComponent
    ],
    imports: [CommonModule, ObserveVisibilityDirectiveModule, PillModule, RouterModule.forChild(routes)],
    exports: [RouterModule]
})
export class ResumeModule {
}
