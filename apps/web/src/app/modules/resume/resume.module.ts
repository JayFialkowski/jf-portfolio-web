import {NgModule} from '@angular/core';
import {RouterModule, Routes} from '@angular/router';
import {ResumeComponent} from './components/resume/resume.component';
import {CommonModule} from '@angular/common';

const routes: Routes = [
    {
        path: '',
        pathMatch: 'full',
        component: ResumeComponent
    }
];

@NgModule({
    declarations: [
        ResumeComponent,
    ],
    imports: [CommonModule, RouterModule.forChild(routes)],
    exports: [RouterModule]
})
export class ResumeModule {
}
